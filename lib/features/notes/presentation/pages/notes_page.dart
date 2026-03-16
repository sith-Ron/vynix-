import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/features/notes/domain/models/note_entry.dart';
import 'package:vynix/features/notes/domain/utils/note_rich_text_utils.dart';
import 'package:vynix/features/notes/presentation/pages/note_editor_page.dart';
import 'package:vynix/features/notes/presentation/providers/notes_providers.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesValue = ref.watch(filteredNotesProvider);
    final tagsValue = ref.watch(noteTagsProvider);
    final filter = ref.watch(notesFilterControllerProvider);

    return AdaptiveSectionScaffold(
      title: 'Notes',
      floatingActionButton: FloatingActionButton(
        heroTag: 'notes_fab',
        tooltip: 'Create note',
        onPressed: () => _openEditor(context),
        child: const Icon(CupertinoIcons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: VynixGlassCard(
                child: TextField(
                  onChanged: ref
                      .read(notesFilterControllerProvider.notifier)
                      .setQuery,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.search),
                    hintText: 'Search notes, text, tags...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            sliver: SliverToBoxAdapter(
              child: tagsValue.when(
                data: (tags) {
                  if (tags.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterChip(
                          selected: filter.selectedTag == null,
                          label: const Text('All'),
                          onSelected: (_) => ref
                              .read(notesFilterControllerProvider.notifier)
                              .setSelectedTag(null),
                        ),
                        const SizedBox(width: 8),
                        ...tags.map(
                          (tag) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              selected: filter.selectedTag == tag,
                              label: Text('#$tag'),
                              onSelected: (_) => ref
                                  .read(notesFilterControllerProvider.notifier)
                                  .setSelectedTag(tag),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                loading: () => const LinearProgressIndicator(minHeight: 2),
                error: (_, _) => const SizedBox.shrink(),
              ),
            ),
          ),
          notesValue.when(
            data: (notes) {
              if (notes.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No notes yet. Tap + to create your first note.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverList.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _NoteCard(
                        note: note,
                        onTap: () => _openEditor(context, note: note),
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
            error: (error, _) => SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('Failed to load notes: $error'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openEditor(BuildContext context, {NoteEntry? note}) async {
    final route = Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoPageRoute<void>(
            builder: (_) => NoteEditorPage(initialNote: note),
          )
        : MaterialPageRoute<void>(
            builder: (_) => NoteEditorPage(initialNote: note),
          );
    await Navigator.of(context).push(route);
  }
}

class _NoteCard extends ConsumerWidget {
  const _NoteCard({required this.note, required this.onTap});

  final NoteEntry note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview = plainTextFromDeltaJson(note.contentDeltaJson);
    final tags = tagsFromJson(note.tagsJson);

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: VynixGlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (note.isPinned)
                  Icon(
                    CupertinoIcons.pin_fill,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              preview,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (tags.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: tags
                    .map(
                      (tag) => Chip(
                        visualDensity: VisualDensity.compact,
                        label: Text('#$tag'),
                        labelStyle: Theme.of(context).textTheme.labelSmall,
                      ),
                    )
                    .toList(growable: false),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
