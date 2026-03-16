import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vynix/core/providers/database_provider.dart';
import 'package:vynix/features/notes/data/repositories/notes_repository.dart';
import 'package:vynix/features/notes/domain/models/note_entry.dart';

part 'notes_providers.g.dart';

@immutable
class NotesFilter {
  const NotesFilter({this.query = '', this.selectedTag});

  final String query;
  final String? selectedTag;

  NotesFilter copyWith({
    String? query,
    String? selectedTag,
    bool clearSelectedTag = false,
  }) {
    return NotesFilter(
      query: query ?? this.query,
      selectedTag: clearSelectedTag ? null : (selectedTag ?? this.selectedTag),
    );
  }
}

@riverpod
NotesRepository notesRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return NotesRepository(db);
}

@riverpod
class NotesFilterController extends _$NotesFilterController {
  @override
  NotesFilter build() => const NotesFilter();

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }

  void setSelectedTag(String? tag) {
    if (tag == null || tag.trim().isEmpty) {
      state = state.copyWith(clearSelectedTag: true);
      return;
    }
    state = state.copyWith(selectedTag: tag.trim());
  }

  void clearFilters() {
    state = const NotesFilter();
  }
}

@riverpod
Stream<List<NoteEntry>> filteredNotes(Ref ref) {
  final filter = ref.watch(notesFilterControllerProvider);
  final repo = ref.watch(notesRepositoryProvider);
  return repo.watchNotes(
    searchQuery: filter.query,
    selectedTag: filter.selectedTag,
  );
}

@riverpod
Stream<List<String>> noteTags(Ref ref) {
  final repo = ref.watch(notesRepositoryProvider);
  return repo.watchAvailableTags();
}

@riverpod
class NotesMutations extends _$NotesMutations {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<NoteEntry> save({
    required NoteEntry? existing,
    required String title,
    required String contentDeltaJson,
    required List<String> tags,
    required bool isPinned,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(notesRepositoryProvider);
    try {
      final sanitizedTitle = title.trim().isEmpty ? 'Untitled' : title.trim();
      final sanitizedTags = tags
          .map((tag) => tag.trim().toLowerCase())
          .where((tag) => tag.isNotEmpty)
          .toSet()
          .toList(growable: false);

      final result = existing == null
          ? await repo.create(
              title: sanitizedTitle,
              contentDeltaJson: contentDeltaJson,
              tags: sanitizedTags,
            )
          : await repo.update(
              note: existing,
              title: sanitizedTitle,
              contentDeltaJson: contentDeltaJson,
              tags: sanitizedTags,
              isPinned: isPinned,
            );

      state = const AsyncData(null);
      return result;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> remove(int noteId) async {
    state = const AsyncLoading();
    final repo = ref.read(notesRepositoryProvider);
    try {
      await repo.delete(noteId);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}
