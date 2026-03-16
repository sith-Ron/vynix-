// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_memos_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VoiceMemosController)
const voiceMemosControllerProvider = VoiceMemosControllerProvider._();

final class VoiceMemosControllerProvider
    extends $NotifierProvider<VoiceMemosController, List<VoiceMemoItem>> {
  const VoiceMemosControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceMemosControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceMemosControllerHash();

  @$internal
  @override
  VoiceMemosController create() => VoiceMemosController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<VoiceMemoItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<VoiceMemoItem>>(value),
    );
  }
}

String _$voiceMemosControllerHash() =>
    r'47cfe317e089627e18b798117cbdf8739d30606d';

abstract class _$VoiceMemosController extends $Notifier<List<VoiceMemoItem>> {
  List<VoiceMemoItem> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<VoiceMemoItem>, List<VoiceMemoItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<VoiceMemoItem>, List<VoiceMemoItem>>,
              List<VoiceMemoItem>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(voiceMemosRepository)
const voiceMemosRepositoryProvider = VoiceMemosRepositoryProvider._();

final class VoiceMemosRepositoryProvider
    extends
        $FunctionalProvider<
          VoiceMemosRepository,
          VoiceMemosRepository,
          VoiceMemosRepository
        >
    with $Provider<VoiceMemosRepository> {
  const VoiceMemosRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceMemosRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceMemosRepositoryHash();

  @$internal
  @override
  $ProviderElement<VoiceMemosRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VoiceMemosRepository create(Ref ref) {
    return voiceMemosRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceMemosRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceMemosRepository>(value),
    );
  }
}

String _$voiceMemosRepositoryHash() =>
    r'b6e4283af1f7c19cb73cd6a5c6c030de5a8f380d';
