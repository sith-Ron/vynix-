import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_editor_ui_provider.g.dart';

@immutable
class NoteEditorUiState {
  const NoteEditorUiState({
    this.tags = const <String>[],
    this.isListening = false,
  });

  final List<String> tags;
  final bool isListening;

  NoteEditorUiState copyWith({List<String>? tags, bool? isListening}) {
    return NoteEditorUiState(
      tags: tags ?? this.tags,
      isListening: isListening ?? this.isListening,
    );
  }
}

@riverpod
class NoteEditorUiController extends _$NoteEditorUiController {
  @override
  NoteEditorUiState build(String editorId) => const NoteEditorUiState();

  void seedTags(List<String> tags) {
    final cleaned = tags
        .map((tag) => tag.trim().toLowerCase())
        .where((tag) => tag.isNotEmpty)
        .toSet()
        .toList(growable: false);
    state = state.copyWith(tags: cleaned);
  }

  void addTag(String tag) {
    final normalized = tag.trim().toLowerCase();
    if (normalized.isEmpty || state.tags.contains(normalized)) {
      return;
    }
    state = state.copyWith(tags: [...state.tags, normalized]);
  }

  void removeTag(String tag) {
    state = state.copyWith(tags: state.tags.where((t) => t != tag).toList());
  }

  void setListening(bool listening) {
    state = state.copyWith(isListening: listening);
  }
}
