// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notesRepository)
const notesRepositoryProvider = NotesRepositoryProvider._();

final class NotesRepositoryProvider
    extends
        $FunctionalProvider<NotesRepository, NotesRepository, NotesRepository>
    with $Provider<NotesRepository> {
  const NotesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notesRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotesRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotesRepository create(Ref ref) {
    return notesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotesRepository>(value),
    );
  }
}

String _$notesRepositoryHash() => r'04819882c9979a1d17c8e3451f1eacf55fec2328';

@ProviderFor(NotesFilterController)
const notesFilterControllerProvider = NotesFilterControllerProvider._();

final class NotesFilterControllerProvider
    extends $NotifierProvider<NotesFilterController, NotesFilter> {
  const NotesFilterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notesFilterControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notesFilterControllerHash();

  @$internal
  @override
  NotesFilterController create() => NotesFilterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotesFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotesFilter>(value),
    );
  }
}

String _$notesFilterControllerHash() =>
    r'46d0a7d344f114634a5bacda506c91849f226de2';

abstract class _$NotesFilterController extends $Notifier<NotesFilter> {
  NotesFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<NotesFilter, NotesFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NotesFilter, NotesFilter>,
              NotesFilter,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(filteredNotes)
const filteredNotesProvider = FilteredNotesProvider._();

final class FilteredNotesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NoteEntry>>,
          List<NoteEntry>,
          Stream<List<NoteEntry>>
        >
    with $FutureModifier<List<NoteEntry>>, $StreamProvider<List<NoteEntry>> {
  const FilteredNotesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredNotesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredNotesHash();

  @$internal
  @override
  $StreamProviderElement<List<NoteEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<NoteEntry>> create(Ref ref) {
    return filteredNotes(ref);
  }
}

String _$filteredNotesHash() => r'602314984a423d7196c09ba4187ae07967410806';

@ProviderFor(noteTags)
const noteTagsProvider = NoteTagsProvider._();

final class NoteTagsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          Stream<List<String>>
        >
    with $FutureModifier<List<String>>, $StreamProvider<List<String>> {
  const NoteTagsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'noteTagsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$noteTagsHash();

  @$internal
  @override
  $StreamProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<String>> create(Ref ref) {
    return noteTags(ref);
  }
}

String _$noteTagsHash() => r'8bfe6b7d23f75cd9b441673cfe0a1f62bdc5b2f7';

@ProviderFor(NotesMutations)
const notesMutationsProvider = NotesMutationsProvider._();

final class NotesMutationsProvider
    extends $NotifierProvider<NotesMutations, AsyncValue<void>> {
  const NotesMutationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notesMutationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notesMutationsHash();

  @$internal
  @override
  NotesMutations create() => NotesMutations();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$notesMutationsHash() => r'99a7ecb8f619c570a896af2039c8cfcd49b4aa8a';

abstract class _$NotesMutations extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
