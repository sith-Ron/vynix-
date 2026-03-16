// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_editor_ui_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NoteEditorUiController)
const noteEditorUiControllerProvider = NoteEditorUiControllerFamily._();

final class NoteEditorUiControllerProvider
    extends $NotifierProvider<NoteEditorUiController, NoteEditorUiState> {
  const NoteEditorUiControllerProvider._({
    required NoteEditorUiControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'noteEditorUiControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$noteEditorUiControllerHash();

  @override
  String toString() {
    return r'noteEditorUiControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  NoteEditorUiController create() => NoteEditorUiController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NoteEditorUiState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NoteEditorUiState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NoteEditorUiControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$noteEditorUiControllerHash() =>
    r'c075f59ca5bff587a4a127f7e0d0fc9b51fba7c6';

final class NoteEditorUiControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          NoteEditorUiController,
          NoteEditorUiState,
          NoteEditorUiState,
          NoteEditorUiState,
          String
        > {
  const NoteEditorUiControllerFamily._()
    : super(
        retry: null,
        name: r'noteEditorUiControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NoteEditorUiControllerProvider call(String editorId) =>
      NoteEditorUiControllerProvider._(argument: editorId, from: this);

  @override
  String toString() => r'noteEditorUiControllerProvider';
}

abstract class _$NoteEditorUiController extends $Notifier<NoteEditorUiState> {
  late final _$args = ref.$arg as String;
  String get editorId => _$args;

  NoteEditorUiState build(String editorId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<NoteEditorUiState, NoteEditorUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NoteEditorUiState, NoteEditorUiState>,
              NoteEditorUiState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
