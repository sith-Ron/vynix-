import 'package:vynix/features/calendar/domain/models/calendar_event_entry.dart';
import 'package:vynix/shared/services/database/app_database.dart';
import 'package:drift/drift.dart' show Value;

class CalendarRepository {
  const CalendarRepository(this._database);

  final AppDatabase _database;

  Stream<List<CalendarEventEntry>> watchMonth(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);
    return _database
        .watchEventsInRange(startInclusive: start, endExclusive: end)
        .map((rows) => rows.map(_toDomain).toList(growable: false));
  }

  Stream<List<CalendarEventEntry>> watchDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return _database
        .watchEventsInRange(startInclusive: start, endExclusive: end)
        .map((rows) => rows.map(_toDomain).toList(growable: false));
  }

  Future<CalendarEventEntry> create({
    required String title,
    required String description,
    required DateTime startAt,
    required DateTime endAt,
    required bool isAllDay,
    required int? reminderMinutes,
  }) async {
    final row = await _database.insertCalendarEvent(
      title: title,
      description: description,
      startAt: startAt,
      endAt: endAt,
      isAllDay: isAllDay,
      reminderMinutes: reminderMinutes,
    );
    return _toDomain(row);
  }

  Future<CalendarEventEntry> update({
    required CalendarEventEntry event,
    required String title,
    required String description,
    required DateTime startAt,
    required DateTime endAt,
    required bool isAllDay,
    required int? reminderMinutes,
  }) async {
    final row = await _database.updateCalendarEvent(
      CalendarEventRecord(
        id: event.id,
        title: event.title,
        description: event.description,
        startAt: event.startAt,
        endAt: event.endAt,
        isAllDay: event.isAllDay,
        reminderMinutes: event.reminderMinutes,
        createdAt: event.createdAt,
        updatedAt: event.updatedAt,
      ).copyWith(
        title: title,
        description: description,
        startAt: startAt,
        endAt: endAt,
        isAllDay: isAllDay,
        reminderMinutes: Value(reminderMinutes),
      ),
    );
    return _toDomain(row);
  }

  Future<void> delete(int eventId) {
    return _database.deleteCalendarEvent(eventId);
  }

  CalendarEventEntry _toDomain(CalendarEventRecord row) {
    return CalendarEventEntry(
      id: row.id,
      title: row.title,
      description: row.description,
      startAt: row.startAt,
      endAt: row.endAt,
      isAllDay: row.isAllDay,
      reminderMinutes: row.reminderMinutes,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
