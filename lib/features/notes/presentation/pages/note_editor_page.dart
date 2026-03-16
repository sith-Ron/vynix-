import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vynix/features/notes/domain/models/note_entry.dart';
import 'package:vynix/features/notes/domain/utils/note_rich_text_utils.dart';
import 'package:vynix/features/notes/presentation/providers/note_editor_ui_provider.dart';
import 'package:vynix/features/notes/presentation/providers/notes_providers.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class NoteEditorPage extends ConsumerStatefulWidget {
  const NoteEditorPage({super.key, this.initialNote});

  final NoteEntry? initialNote;

  @override
  ConsumerState<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends ConsumerState<NoteEditorPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _tagController;
  late final quill.QuillController _quillController;
  late final SpeechToText _speechToText;
  late final String _editorId;
  late final FocusNode _editorFocusNode;
  late final ScrollController _editorScrollController;

  bool get _isEditMode => widget.initialNote != null;

  @override
  void initState() {
    super.initState();
    _editorId =
        widget.initialNote?.id.toString() ??
        'new-${DateTime.now().microsecondsSinceEpoch}';
    _titleController = TextEditingController(text: widget.initialNote?.title);
    _tagController = TextEditingController();
    _quillController = quill.QuillController(
      document: documentFromDeltaJson(widget.initialNote?.contentDeltaJson),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _speechToText = SpeechToText();
    _editorFocusNode = FocusNode();
    _editorScrollController = ScrollController();

    final initialTags = widget.initialNote == null
        ? const <String>[]
        : tagsFromJson(widget.initialNote!.tagsJson);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      ref
          .read(noteEditorUiControllerProvider(_editorId).notifier)
          .seedTags(initialTags);
    });
  }

  @override
  void dispose() {
    unawaited(_speechToText.stop());
    _titleController.dispose();
    _tagController.dispose();
    _quillController.dispose();
    _editorFocusNode.dispose();
    _editorScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editorUi = ref.watch(noteEditorUiControllerProvider(_editorId));
    final mutationState = ref.watch(notesMutationsProvider);

    return AdaptiveSectionScaffold(
      title: _isEditMode ? 'Edit Note' : 'New Note',
      trailing: IconButton(
        tooltip: 'Save note',
        onPressed: mutationState.isLoading ? null : () => _save(editorUi.tags),
        icon: const Icon(CupertinoIcons.check_mark_circled_solid),
      ),
      body: CustomScrollView(
        slivers: [
          if (mutationState.isLoading)
            const SliverToBoxAdapter(
              child: LinearProgressIndicator(minHeight: 2),
            ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                VynixGlassCard(
                  child: TextField(
                    controller: _titleController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                    ),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 12),
                VynixGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _tagController,
                              onSubmitted: _addTag,
                              decoration: const InputDecoration(
                                hintText: 'Add tag and press enter',
                                border: InputBorder.none,
                                prefixIcon: Icon(CupertinoIcons.tag),
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Add tag',
                            onPressed: () => _addTag(_tagController.text),
                            icon: const Icon(CupertinoIcons.add_circled),
                          ),
                        ],
                      ),
                      if (editorUi.tags.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: editorUi.tags
                              .map(
                                (tag) => Chip(
                                  label: Text('#$tag'),
                                  onDeleted: () => ref
                                      .read(
                                        noteEditorUiControllerProvider(
                                          _editorId,
                                        ).notifier,
                                      )
                                      .removeTag(tag),
                                ),
                              )
                              .toList(growable: false),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                VynixGlassCard(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                  child: Column(
                    children: [
                      quill.QuillSimpleToolbar(
                        controller: _quillController,
                        config: const quill.QuillSimpleToolbarConfig(
                          showQuote: false,
                          showCodeBlock: false,
                          showClipboardPaste: true,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 320),
                        child: quill.QuillEditor(
                          controller: _quillController,
                          focusNode: _editorFocusNode,
                          scrollController: _editorScrollController,
                          config: const quill.QuillEditorConfig(
                            placeholder: 'Write your note...',
                            expands: false,
                            padding: EdgeInsets.all(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: mutationState.isLoading
                            ? null
                            : () => _toggleSpeech(editorUi.isListening),
                        icon: Icon(
                          editorUi.isListening
                              ? CupertinoIcons.waveform_circle_fill
                              : CupertinoIcons.mic,
                        ),
                        label: Text(
                          editorUi.isListening
                              ? 'Listening... Tap to stop'
                              : 'Voice-to-text memo',
                        ),
                      ),
                    ),
                  ],
                ),
                if (_isEditMode) ...[
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: mutationState.isLoading ? null : _delete,
                    icon: const Icon(CupertinoIcons.trash),
                    label: const Text('Delete note'),
                  ),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _addTag(String rawTag) {
    ref.read(noteEditorUiControllerProvider(_editorId).notifier).addTag(rawTag);
    _tagController.clear();
  }

  Future<void> _toggleSpeech(bool currentlyListening) async {
    final notifier = ref.read(
      noteEditorUiControllerProvider(_editorId).notifier,
    );

    if (currentlyListening) {
      await _speechToText.stop();
      notifier.setListening(false);
      return;
    }

    final available = await _speechToText.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          notifier.setListening(false);
        }
      },
      onError: (_) => notifier.setListening(false),
    );

    if (!available) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Speech recognition is unavailable.')),
        );
      }
      return;
    }

    notifier.setListening(true);
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenOptions: SpeechListenOptions(partialResults: true),
    );
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    final transcript = result.recognizedWords.trim();
    if (transcript.isEmpty) {
      return;
    }

    final currentOffset = _quillController.selection.baseOffset;
    final safeOffset = currentOffset < 0
        ? _quillController.document.length - 1
        : currentOffset;
    final text = '$transcript ';

    _quillController.document.insert(safeOffset, text);
    _quillController.updateSelection(
      TextSelection.collapsed(offset: safeOffset + text.length),
      quill.ChangeSource.local,
    );
  }

  Future<void> _save(List<String> tags) async {
    final deltaJson = deltaJsonFromController(_quillController);
    final mutation = ref.read(notesMutationsProvider.notifier);
    await mutation.save(
      existing: widget.initialNote,
      title: _titleController.text,
      contentDeltaJson: deltaJson,
      tags: tags,
      isPinned: widget.initialNote?.isPinned ?? false,
    );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    final note = widget.initialNote;
    if (note == null) {
      return;
    }

    final result = await showOkCancelAlertDialog(
      context: context,
      title: 'Delete note?',
      message: 'This action cannot be undone.',
      okLabel: 'Delete',
      isDestructiveAction: true,
    );

    if (result != OkCancelResult.ok) {
      return;
    }

    await ref.read(notesMutationsProvider.notifier).remove(note.id);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
