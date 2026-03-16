import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vynix/core/providers/database_provider.dart';
import 'package:vynix/core/providers/local_notifications_provider.dart';
import 'package:vynix/features/pomodoro/data/repositories/pomodoro_repository.dart';

part 'pomodoro_provider.g.dart';

enum PomodoroPhase { focus, shortBreak, longBreak }

enum FocusSessionMode { oneTime, repeated }

@immutable
class PomodoroState {
  const PomodoroState({
    required this.phase,
    required this.remaining,
    this.focusDurationMinutes = 25,
    this.sessionMode = FocusSessionMode.repeated,
    this.running = false,
    this.completedFocusSessions = 0,
    this.totalFocusSeconds = 0,
    this.cycles = 0,
  });

  final PomodoroPhase phase;
  final Duration remaining;
  final int focusDurationMinutes;
  final FocusSessionMode sessionMode;
  final bool running;
  final int completedFocusSessions;
  final int totalFocusSeconds;
  final int cycles;

  PomodoroState copyWith({
    PomodoroPhase? phase,
    Duration? remaining,
    int? focusDurationMinutes,
    FocusSessionMode? sessionMode,
    bool? running,
    int? completedFocusSessions,
    int? totalFocusSeconds,
    int? cycles,
  }) {
    return PomodoroState(
      phase: phase ?? this.phase,
      remaining: remaining ?? this.remaining,
      focusDurationMinutes: focusDurationMinutes ?? this.focusDurationMinutes,
      sessionMode: sessionMode ?? this.sessionMode,
      running: running ?? this.running,
      completedFocusSessions:
          completedFocusSessions ?? this.completedFocusSessions,
      totalFocusSeconds: totalFocusSeconds ?? this.totalFocusSeconds,
      cycles: cycles ?? this.cycles,
    );
  }
}

@riverpod
class PomodoroController extends _$PomodoroController {
  static const Duration _shortBreakDuration = Duration(minutes: 5);
  static const Duration _longBreakDuration = Duration(minutes: 15);

  Timer? _timer;
  StreamSubscription? _statsSub;

  @override
  PomodoroState build() {
    if (_statsSub == null) {
      final repo = ref.read(pomodoroRepositoryProvider);
      _statsSub = repo.watchStats().listen((stats) {
        final nextFocusMinutes = stats.focusMinutes.clamp(5, 120);
        final nextRemaining =
            state.phase == PomodoroPhase.focus && !state.running
            ? Duration(minutes: nextFocusMinutes)
            : state.remaining;

        state = state.copyWith(
          remaining: nextRemaining,
          focusDurationMinutes: nextFocusMinutes,
          completedFocusSessions: stats.completedFocusSessions,
          totalFocusSeconds: stats.totalFocusSeconds,
          cycles: stats.cycles,
        );
      });
    }
    ref.onDispose(() {
      _timer?.cancel();
      _statsSub?.cancel();
    });
    return const PomodoroState(
      phase: PomodoroPhase.focus,
      remaining: Duration(minutes: 25),
    );
  }

  void setFocusDurationMinutes(int minutes) {
    final clamped = minutes.clamp(5, 120);
    state = state.copyWith(
      focusDurationMinutes: clamped,
      remaining: state.phase == PomodoroPhase.focus && !state.running
          ? Duration(minutes: clamped)
          : state.remaining,
    );
    unawaited(_persistStats());
  }

  void start({FocusSessionMode? mode}) {
    if (state.running) {
      return;
    }
    state = state.copyWith(
      sessionMode: mode ?? state.sessionMode,
      running: true,
    );
    if (state.phase == PomodoroPhase.focus) {
      unawaited(
        ref
            .read(localNotificationsServiceProvider)
            .scheduleFocusSessionCompletion(
              after: state.remaining,
              repeated: state.sessionMode == FocusSessionMode.repeated,
              completedSessions: state.completedFocusSessions + 1,
            ),
      );
    }
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final next = state.remaining - const Duration(seconds: 1);
      if (next <= Duration.zero) {
        _advancePhase();
      } else {
        final extraFocus = state.phase == PomodoroPhase.focus ? 1 : 0;
        state = state.copyWith(
          remaining: next,
          totalFocusSeconds: state.totalFocusSeconds + extraFocus,
        );
      }
    });
  }

  void pause() {
    _timer?.cancel();
    state = state.copyWith(running: false);
    unawaited(
      ref
          .read(localNotificationsServiceProvider)
          .cancelFocusSessionCompletion(),
    );
    unawaited(_persistStats());
  }

  void reset() {
    _timer?.cancel();
    state = state.copyWith(
      phase: PomodoroPhase.focus,
      remaining: Duration(minutes: state.focusDurationMinutes),
      running: false,
    );
    unawaited(
      ref
          .read(localNotificationsServiceProvider)
          .cancelFocusSessionCompletion(),
    );
    unawaited(_persistStats());
  }

  void _advancePhase() {
    final wasFocus = state.phase == PomodoroPhase.focus;
    final nextCycles = wasFocus ? state.cycles + 1 : state.cycles;
    final nextCompleted = state.completedFocusSessions + (wasFocus ? 1 : 0);

    if (wasFocus) {
      unawaited(
        ref
            .read(localNotificationsServiceProvider)
            .cancelFocusSessionCompletion(),
      );
      unawaited(
        ref
            .read(localNotificationsServiceProvider)
            .notifyFocusSessionCompleted(
              repeated: state.sessionMode == FocusSessionMode.repeated,
              completedSessions: nextCompleted,
            ),
      );
    }

    if (wasFocus && state.sessionMode == FocusSessionMode.oneTime) {
      _timer?.cancel();
      state = state.copyWith(
        phase: PomodoroPhase.focus,
        remaining: Duration(minutes: state.focusDurationMinutes),
        running: false,
        completedFocusSessions: nextCompleted,
        cycles: nextCycles,
      );
      unawaited(_persistStats());
      return;
    }

    final nextPhase = switch (state.phase) {
      PomodoroPhase.focus =>
        nextCycles % 4 == 0
            ? PomodoroPhase.longBreak
            : PomodoroPhase.shortBreak,
      PomodoroPhase.shortBreak ||
      PomodoroPhase.longBreak => PomodoroPhase.focus,
    };

    final nextDuration = switch (nextPhase) {
      PomodoroPhase.focus => Duration(minutes: state.focusDurationMinutes),
      PomodoroPhase.shortBreak => _shortBreakDuration,
      PomodoroPhase.longBreak => _longBreakDuration,
    };

    state = state.copyWith(
      phase: nextPhase,
      remaining: nextDuration,
      completedFocusSessions: nextCompleted,
      cycles: nextCycles,
    );

    if (nextPhase == PomodoroPhase.focus && state.running) {
      unawaited(
        ref
            .read(localNotificationsServiceProvider)
            .scheduleFocusSessionCompletion(
              after: state.remaining,
              repeated: state.sessionMode == FocusSessionMode.repeated,
              completedSessions: state.completedFocusSessions + 1,
            ),
      );
    }

    unawaited(_persistStats());
  }

  Future<void> _persistStats() {
    return ref
        .read(pomodoroRepositoryProvider)
        .saveStats(
          completedFocusSessions: state.completedFocusSessions,
          totalFocusSeconds: state.totalFocusSeconds,
          cycles: state.cycles,
          focusMinutes: state.focusDurationMinutes,
        );
  }
}

@riverpod
PomodoroRepository pomodoroRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return PomodoroRepository(db);
}
