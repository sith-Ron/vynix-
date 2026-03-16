import 'package:flutter/foundation.dart';

@immutable
class CalendarEventEntry {
  const CalendarEventEntry({
    required this.id,
    required this.title,
    required this.description,
    required this.startAt,
    required this.endAt,
    required this.isAllDay,
    required this.reminderMinutes,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String description;
  final DateTime startAt;
  final DateTime endAt;
  final bool isAllDay;
  final int? reminderMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;
}
