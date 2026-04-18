import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vynix/core/providers/app_settings_provider.dart';
import 'package:vynix/core/providers/database_provider.dart';
import 'package:vynix/core/providers/local_notifications_provider.dart';
import 'package:vynix/features/alarms/data/repositories/alarms_repository.dart';
import 'package:vynix/shared/services/database/app_database.dart';

part 'alarms_provider.g.dart';

@immutable
class AlarmItem {
  const AlarmItem({
    required this.id,
    required this.hour,
    required this.minute,
    this.label = 'Alarm',
    this.enabled = true,
    this.recurringWeekdays = const <int>{},
    this.snoozeMinutes = 10,
    this.vibration = true,
    this.sound = true,
  });

  final int id;
  final int hour;
  final int minute;
  final String label;
  final bool enabled;
  final Set<int> recurringWeekdays;
  final int snoozeMinutes;
  final bool vibration;
  final bool sound;

  AlarmItem copyWith({
    int? id,
    int? hour,
    int? minute,
    String? label,
    bool? enabled,
    Set<int>? recurringWeekdays,
    int? snoozeMinutes,
    bool? vibration,
    bool? sound,
  }) {
    return AlarmItem(
      id: id ?? this.id,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      label: label ?? this.label,
      enabled: enabled ?? this.enabled,
      recurringWeekdays: recurringWeekdays ?? this.recurringWeekdays,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
      vibration: vibration ?? this.vibration,
      sound: sound ?? this.sound,
    );
  }
}

@riverpod
class AlarmsController extends _$AlarmsController {
  StreamSubscription<List<AlarmRecord>>? _sub;

  @override
  List<AlarmItem> build() {
    if (_sub == null) {
      final repo = ref.read(alarmsRepositoryProvider);
      _sub = repo.watchAlarms().listen((rows) {
        final mapped = rows.map(_fromRecord).toList(growable: false);
        state = mapped;

        // Keep scheduled notifications in sync after app restart.
        for (final alarm in mapped) {
          if (alarm.enabled) {
            unawaited(_syncAlarm(alarm));
          }
        }
      });
      ref.onDispose(() => _sub?.cancel());
    }
    return const [];
  }

  Future<void> addAlarm({
    required int hour,
    required int minute,
    required String label,
    required Set<int> recurringWeekdays,
    required int snoozeMinutes,
    required bool vibration,
    required bool sound,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch % 100000;
    final alarm = AlarmItem(
      id: id,
      hour: hour,
      minute: minute,
      label: label.trim().isEmpty ? 'Alarm' : label.trim(),
      recurringWeekdays: recurringWeekdays,
      snoozeMinutes: snoozeMinutes,
      vibration: vibration,
      sound: sound,
    );
    await _persist(alarm);
    await _syncAlarm(alarm);
  }

  Future<void> toggleEnabled(int id) async {
    AlarmItem? updated;
    for (final alarm in state) {
      if (alarm.id == id) {
        updated = alarm.copyWith(enabled: !alarm.enabled);
        break;
      }
    }
    if (updated == null) {
      return;
    }

    final alarm = updated;
    await _persist(alarm);
    if (!alarm.enabled) {
      await ref.read(localNotificationsServiceProvider).cancelAlarm(alarm.id);
    } else {
      await _syncAlarm(alarm);
    }
  }

  Future<void> removeAlarm(int id) async {
    await ref.read(alarmsRepositoryProvider).delete(id);
    await ref.read(localNotificationsServiceProvider).cancelAlarm(id);
  }

  Future<void> snooze(int id) async {
    AlarmItem? alarm;
    for (final item in state) {
      if (item.id == id) {
        alarm = item;
        break;
      }
    }
    if (alarm == null) {
      return;
    }
    final settings = ref.read(appSettingsControllerProvider);
    await ref
        .read(localNotificationsServiceProvider)
        .snoozeAlarm(
          alarmId: alarm.id,
          title: alarm.label,
          body: 'Snoozed alarm',
          snoozeMinutes: alarm.snoozeMinutes,
          notificationSound: settings.notificationSound,
        );
  }

  Future<void> _syncAlarm(AlarmItem alarm) async {
    if (!alarm.enabled) {
      return;
    }
    final settings = ref.read(appSettingsControllerProvider);
    await ref
        .read(localNotificationsServiceProvider)
        .syncAlarm(
          alarmId: alarm.id,
          title: alarm.label,
          body: 'Alarm time',
          hour: alarm.hour,
          minute: alarm.minute,
          weekdays: alarm.recurringWeekdays,
          vibration: alarm.vibration,
          sound: alarm.sound,
          notificationSound: settings.notificationSound,
        );
  }

  Future<void> _persist(AlarmItem alarm) {
    return ref
        .read(alarmsRepositoryProvider)
        .upsert(
          AlarmsCompanion(
            id: Value(alarm.id),
            hour: Value(alarm.hour),
            minute: Value(alarm.minute),
            label: Value(alarm.label),
            enabled: Value(alarm.enabled),
            recurringWeekdaysJson: Value(
              jsonEncode(alarm.recurringWeekdays.toList(growable: false)),
            ),
            snoozeMinutes: Value(alarm.snoozeMinutes),
            vibration: Value(alarm.vibration),
            sound: Value(alarm.sound),
          ),
        );
  }

  AlarmItem _fromRecord(AlarmRecord row) {
    final weekdays = <int>{};
    try {
      final decoded = jsonDecode(row.recurringWeekdaysJson);
      if (decoded is List) {
        for (final day in decoded) {
          final parsed = int.tryParse(day.toString());
          if (parsed != null && parsed >= 1 && parsed <= 7) {
            weekdays.add(parsed);
          }
        }
      }
    } catch (_) {
      // Keep resilient on malformed payloads.
    }

    return AlarmItem(
      id: row.id,
      hour: row.hour,
      minute: row.minute,
      label: row.label,
      enabled: row.enabled,
      recurringWeekdays: weekdays,
      snoozeMinutes: row.snoozeMinutes,
      vibration: row.vibration,
      sound: row.sound,
    );
  }
}

@riverpod
AlarmsRepository alarmsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return AlarmsRepository(db);
}
