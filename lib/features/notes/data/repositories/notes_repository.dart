import 'dart:convert';

import 'package:vynix/features/notes/domain/models/note_entry.dart';
import 'package:vynix/shared/services/database/app_database.dart';

class NotesRepository {
  const NotesRepository(this._database);

  final AppDatabase _database;

  Stream<List<NoteEntry>> watchNotes({
    required String searchQuery,
    String? selectedTag,
  }) {
    return _database
        .watchNotes(searchQuery: searchQuery, selectedTag: selectedTag)
        .map((rows) => rows.map(_toNoteEntry).toList(growable: false));
  }

  Stream<List<String>> watchAvailableTags() => _database.watchAllTags();

  Future<NoteEntry> create({
    required String title,
    required String contentDeltaJson,
    required List<String> tags,
  }) async {
    final record = await _database.insertNote(
      title: title,
      contentDeltaJson: contentDeltaJson,
      tagsJson: jsonEncode(tags),
    );
    return _toNoteEntry(record);
  }

  Future<NoteEntry> update({
    required NoteEntry note,
    required String title,
    required String contentDeltaJson,
    required List<String> tags,
    required bool isPinned,
  }) async {
    final record = await _database.updateNote(
      NoteRecord(
        id: note.id,
        title: note.title,
        contentDeltaJson: note.contentDeltaJson,
        tagsJson: note.tagsJson,
        isPinned: note.isPinned,
        createdAt: note.createdAt,
        updatedAt: note.updatedAt,
      ).copyWith(
        title: title,
        contentDeltaJson: contentDeltaJson,
        tagsJson: jsonEncode(tags),
        isPinned: isPinned,
      ),
    );
    return _toNoteEntry(record);
  }

  Future<void> delete(int noteId) => _database.deleteNote(noteId);

  NoteEntry _toNoteEntry(NoteRecord row) {
    return NoteEntry(
      id: row.id,
      title: row.title,
      contentDeltaJson: row.contentDeltaJson,
      tagsJson: row.tagsJson,
      isPinned: row.isPinned,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
