import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/app.dart';
import 'package:vynix/features/notes/domain/models/note_entry.dart';
import 'package:vynix/features/notes/presentation/providers/notes_providers.dart';

void main() {
  testWidgets('vynix shell renders core tabs', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          filteredNotesProvider.overrideWith(
            (ref) => Stream<List<NoteEntry>>.value(const <NoteEntry>[]),
          ),
          noteTagsProvider.overrideWith(
            (ref) => Stream<List<String>>.value(const <String>[]),
          ),
        ],
        child: const VynixApp(),
      ),
    );

    expect(find.text('Notes'), findsWidgets);
    expect(find.text('Calendar'), findsWidgets);
    expect(find.text('Tasks'), findsWidgets);
  });
}
