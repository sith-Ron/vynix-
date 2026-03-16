import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vynix/core/providers/database_provider.dart';
import 'package:vynix/features/habits/data/repositories/habits_repository.dart';
import 'package:vynix/shared/services/database/app_database.dart';

part 'habits_provider.g.dart';

@immutable
class HabitItem {
  const HabitItem({
    required this.id,
    required this.title,
    required this.targetPerWeek,
    this.completedDays = const <String>{},
  });

  final String id;
  final String title;
  final int targetPerWeek;
  final Set<String> completedDays;

  HabitItem copyWith({
    String? id,
    String? title,
    int? targetPerWeek,
    Set<String>? completedDays,
  }) {
    return HabitItem(
      id: id ?? this.id,
      title: title ?? this.title,
      targetPerWeek: targetPerWeek ?? this.targetPerWeek,
      completedDays: completedDays ?? this.completedDays,
    );
  }
}

String _key(DateTime day) => '${day.year}-${day.month}-${day.day}';

@riverpod
class HabitsController extends _$HabitsController {
  StreamSubscription<List<HabitRecord>>? _sub;

  @override
  List<HabitItem> build() {
    if (_sub == null) {
      final repo = ref.read(habitsRepositoryProvider);
      _sub = repo.watchHabits().listen((rows) {
        state = rows.map(_fromRecord).toList(growable: false);
      });
      ref.onDispose(() => _sub?.cancel());
    }
    return const [];
  }

  void addHabit({required String title, required int targetPerWeek}) {
    final cleaned = title.trim();
    if (cleaned.isEmpty) {
      return;
    }
    final item = HabitItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: cleaned,
      targetPerWeek: targetPerWeek,
    );
    unawaited(_persist(item));
  }

  void toggleToday(String id) {
    final todayKey = _key(DateTime.now());
    for (final item in state) {
      if (item.id == id) {
        final updated = item.copyWith(
          completedDays: item.completedDays.contains(todayKey)
              ? (item.completedDays.toSet()..remove(todayKey))
              : (item.completedDays.toSet()..add(todayKey)),
        );
        unawaited(_persist(updated));
        break;
      }
    }
  }

  void removeHabit(String id) {
    unawaited(ref.read(habitsRepositoryProvider).delete(id));
  }

  Future<void> _persist(HabitItem item) {
    return ref
        .read(habitsRepositoryProvider)
        .upsert(
          HabitsCompanion(
            id: Value(item.id),
            title: Value(item.title),
            targetPerWeek: Value(item.targetPerWeek),
            completedDaysJson: Value(
              jsonEncode(item.completedDays.toList(growable: false)),
            ),
          ),
        );
  }

  HabitItem _fromRecord(HabitRecord row) {
    final completed = <String>{};
    try {
      final decoded = jsonDecode(row.completedDaysJson);
      if (decoded is List) {
        for (final day in decoded) {
          final value = day.toString().trim();
          if (value.isNotEmpty) {
            completed.add(value);
          }
        }
      }
    } catch (_) {
      // Keep resilient on malformed payloads.
    }

    return HabitItem(
      id: row.id,
      title: row.title,
      targetPerWeek: row.targetPerWeek,
      completedDays: completed,
    );
  }
}

@riverpod
HabitsRepository habitsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return HabitsRepository(db);
}

@immutable
class HabitStats {
  const HabitStats({
    required this.totalHabits,
    required this.todayCompleted,
    required this.weeklyCompletionRate,
  });

  final int totalHabits;
  final int todayCompleted;
  final double weeklyCompletionRate;
}

@riverpod
HabitStats habitStats(Ref ref) {
  final habits = ref.watch(habitsControllerProvider);
  if (habits.isEmpty) {
    return const HabitStats(
      totalHabits: 0,
      todayCompleted: 0,
      weeklyCompletionRate: 0,
    );
  }

  final todayKey = _key(DateTime.now());
  final now = DateTime.now();
  final weekKeys = List.generate(7, (index) {
    final day = now.subtract(Duration(days: index));
    return _key(day);
  }).toSet();

  int doneThisWeek = 0;
  int targetThisWeek = 0;
  int doneToday = 0;

  for (final habit in habits) {
    if (habit.completedDays.contains(todayKey)) {
      doneToday++;
    }
    doneThisWeek += habit.completedDays.where(weekKeys.contains).length;
    targetThisWeek += habit.targetPerWeek;
  }

  final rate = targetThisWeek == 0 ? 0.0 : doneThisWeek / targetThisWeek;

  return HabitStats(
    totalHabits: habits.length,
    todayCompleted: doneToday,
    weeklyCompletionRate: rate.clamp(0, 1),
  );
}
