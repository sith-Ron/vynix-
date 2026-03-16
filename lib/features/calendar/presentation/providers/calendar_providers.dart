import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vynix/core/providers/database_provider.dart';
import 'package:vynix/core/providers/local_notifications_provider.dart';
import 'package:vynix/features/calendar/data/repositories/calendar_repository.dart';
import 'package:vynix/features/calendar/domain/models/calendar_event_entry.dart';

part 'calendar_providers.g.dart';

DateTime _dayOnly(DateTime value) {
  return DateTime(value.year, value.month, value.day);
}

DateTime _monthOnly(DateTime value) {
  return DateTime(value.year, value.month, 1);
}

@riverpod
CalendarRepository calendarRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return CalendarRepository(db);
}

@riverpod
class CalendarVisibleMonth extends _$CalendarVisibleMonth {
  @override
  DateTime build() => _monthOnly(DateTime.now());

  void setMonth(DateTime month) {
    state = _monthOnly(month);
  }

  void nextMonth() {
    state = DateTime(state.year, state.month + 1, 1);
  }

  void previousMonth() {
    state = DateTime(state.year, state.month - 1, 1);
  }
}

@riverpod
class CalendarSelectedDay extends _$CalendarSelectedDay {
  @override
  DateTime build() => _dayOnly(DateTime.now());

  void setDay(DateTime day) {
    state = _dayOnly(day);
  }
}

@riverpod
Stream<List<CalendarEventEntry>> calendarMonthEvents(Ref ref) {
  final month = ref.watch(calendarVisibleMonthProvider);
  final repo = ref.watch(calendarRepositoryProvider);
  return repo.watchMonth(month);
}

@riverpod
Stream<List<CalendarEventEntry>> calendarDayAgenda(Ref ref) {
  final day = ref.watch(calendarSelectedDayProvider);
  final repo = ref.watch(calendarRepositoryProvider);
  return repo.watchDay(day);
}

@riverpod
class CalendarMutations extends _$CalendarMutations {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<CalendarEventEntry> save({
    required CalendarEventEntry? existing,
    required String title,
    required String description,
    required DateTime startAt,
    required DateTime endAt,
    required bool isAllDay,
    required int? reminderMinutes,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(calendarRepositoryProvider);
    final notifications = ref.read(localNotificationsServiceProvider);

    final effectiveTitle = title.trim().isEmpty ? 'New Event' : title.trim();
    final effectiveDescription = description.trim();
    final normalizedEnd = endAt.isBefore(startAt)
        ? startAt.add(const Duration(minutes: 30))
        : endAt;

    try {
      final result = existing == null
          ? await repo.create(
              title: effectiveTitle,
              description: effectiveDescription,
              startAt: startAt,
              endAt: normalizedEnd,
              isAllDay: isAllDay,
              reminderMinutes: reminderMinutes,
            )
          : await repo.update(
              event: existing,
              title: effectiveTitle,
              description: effectiveDescription,
              startAt: startAt,
              endAt: normalizedEnd,
              isAllDay: isAllDay,
              reminderMinutes: reminderMinutes,
            );

      await notifications.syncCalendarReminder(result);

      state = const AsyncData(null);
      return result;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> remove(int eventId) async {
    state = const AsyncLoading();
    final repo = ref.read(calendarRepositoryProvider);
    final notifications = ref.read(localNotificationsServiceProvider);
    try {
      await repo.delete(eventId);
      await notifications.cancelCalendarReminder(eventId);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}

@immutable
class CalendarEventDraft {
  const CalendarEventDraft({
    required this.startAt,
    required this.endAt,
    this.isAllDay = false,
    this.reminderMinutes,
  });

  final DateTime startAt;
  final DateTime endAt;
  final bool isAllDay;
  final int? reminderMinutes;

  CalendarEventDraft copyWith({
    DateTime? startAt,
    DateTime? endAt,
    bool? isAllDay,
    int? reminderMinutes,
    bool clearReminder = false,
  }) {
    return CalendarEventDraft(
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      isAllDay: isAllDay ?? this.isAllDay,
      reminderMinutes: clearReminder
          ? null
          : (reminderMinutes ?? this.reminderMinutes),
    );
  }
}

@riverpod
class CalendarEventDraftController extends _$CalendarEventDraftController {
  @override
  CalendarEventDraft build(String draftId) {
    final now = DateTime.now();
    final rounded = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute < 30 ? 0 : 30,
    );
    return CalendarEventDraft(
      startAt: rounded,
      endAt: rounded.add(const Duration(hours: 1)),
    );
  }

  void seedFrom({
    required DateTime startAt,
    required DateTime endAt,
    required bool isAllDay,
    required int? reminderMinutes,
  }) {
    state = CalendarEventDraft(
      startAt: startAt,
      endAt: endAt,
      isAllDay: isAllDay,
      reminderMinutes: reminderMinutes,
    );
  }

  void setStart(DateTime dateTime) {
    final adjustedEnd = state.endAt.isBefore(dateTime)
        ? dateTime.add(const Duration(hours: 1))
        : state.endAt;
    state = state.copyWith(startAt: dateTime, endAt: adjustedEnd);
  }

  void setEnd(DateTime dateTime) {
    final adjustedEnd = dateTime.isBefore(state.startAt)
        ? state.startAt.add(const Duration(hours: 1))
        : dateTime;
    state = state.copyWith(endAt: adjustedEnd);
  }

  void setAllDay(bool allDay) {
    state = state.copyWith(isAllDay: allDay);
  }

  void setReminderMinutes(int? minutes) {
    if (minutes == null) {
      state = state.copyWith(clearReminder: true);
      return;
    }
    state = state.copyWith(reminderMinutes: minutes);
  }
}
