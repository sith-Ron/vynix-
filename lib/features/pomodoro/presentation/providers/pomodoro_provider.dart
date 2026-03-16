import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vynix/core/providers/database_provider.dart';
import 'package:vynix/features/pomodoro/data/repositories/pomodoro_repository.dart';

part 'pomodoro_provider.g.dart';

enum PomodoroPhase { focus, shortBreak, longBreak }

@immutable
class PomodoroState {
  const PomodoroState({
    required this.phase,
    required this.remaining,
    this.running = false,
    this.completedFocusSessions = 0,
    this.totalFocusSeconds = 0,
    this.cycles = 0,
  });

  final PomodoroPhase phase;
  final Duration remaining;
  final bool running;
  final int completedFocusSessions;
  final int totalFocusSeconds;
  final int cycles;

  PomodoroState copyWith({
    PomodoroPhase? phase,
    Duration? remaining,
    bool? running,
    int? completedFocusSessions,
    int? totalFocusSeconds,
    int? cycles,
  }) {
    return PomodoroState(
      phase: phase ?? this.phase,
      remaining: remaining ?? this.remaining,
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
  static const Duration _focusDuration = Duration(minutes: 25);
  static const Duration _shortBreakDuration = Duration(minutes: 5);
  static const Duration _longBreakDuration = Duration(minutes: 15);

  Timer? _timer;
  StreamSubscription? _statsSub;

  @override
  PomodoroState build() {
    if (_statsSub == null) {
      final repo = ref.read(pomodoroRepositoryProvider);
      _statsSub = repo.watchStats().listen((stats) {
        state = state.copyWith(
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
      remaining: _focusDuration,
    );
  }

  void start() {
    if (state.running) {
      return;
    }
    state = state.copyWith(running: true);
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
    unawaited(_persistStats());
  }

  void reset() {
    _timer?.cancel();
    state = const PomodoroState(
      phase: PomodoroPhase.focus,
      remaining: _focusDuration,
    );
    unawaited(_persistStats());
  }

  void _advancePhase() {
    final wasFocus = state.phase == PomodoroPhase.focus;
    final nextCycles = wasFocus ? state.cycles + 1 : state.cycles;

    final nextPhase = switch (state.phase) {
      PomodoroPhase.focus =>
        nextCycles % 4 == 0
            ? PomodoroPhase.longBreak
            : PomodoroPhase.shortBreak,
      PomodoroPhase.shortBreak ||
      PomodoroPhase.longBreak => PomodoroPhase.focus,
    };

    final nextDuration = switch (nextPhase) {
      PomodoroPhase.focus => _focusDuration,
      PomodoroPhase.shortBreak => _shortBreakDuration,
      PomodoroPhase.longBreak => _longBreakDuration,
    };

    state = state.copyWith(
      phase: nextPhase,
      remaining: nextDuration,
      completedFocusSessions: state.completedFocusSessions + (wasFocus ? 1 : 0),
      cycles: nextCycles,
    );
    unawaited(_persistStats());
  }

  Future<void> _persistStats() {
    return ref
        .read(pomodoroRepositoryProvider)
        .saveStats(
          completedFocusSessions: state.completedFocusSessions,
          totalFocusSeconds: state.totalFocusSeconds,
          cycles: state.cycles,
        );
  }
}

@riverpod
PomodoroRepository pomodoroRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return PomodoroRepository(db);
}
