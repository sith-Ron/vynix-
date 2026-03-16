import 'package:flutter/foundation.dart';

@immutable
class NoteEntry {
  const NoteEntry({
    required this.id,
    required this.title,
    required this.contentDeltaJson,
    required this.tagsJson,
    required this.isPinned,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String contentDeltaJson;
  final String tagsJson;
  final bool isPinned;
  final DateTime createdAt;
  final DateTime updatedAt;
}
