// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PomodoroController)
const pomodoroControllerProvider = PomodoroControllerProvider._();

final class PomodoroControllerProvider
    extends $NotifierProvider<PomodoroController, PomodoroState> {
  const PomodoroControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pomodoroControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pomodoroControllerHash();

  @$internal
  @override
  PomodoroController create() => PomodoroController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PomodoroState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PomodoroState>(value),
    );
  }
}

String _$pomodoroControllerHash() =>
    r'2e256991a4da418997c6d70ba0f4b3ec84c6cf8b';

abstract class _$PomodoroController extends $Notifier<PomodoroState> {
  PomodoroState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PomodoroState, PomodoroState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PomodoroState, PomodoroState>,
              PomodoroState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(pomodoroRepository)
const pomodoroRepositoryProvider = PomodoroRepositoryProvider._();

final class PomodoroRepositoryProvider
    extends
        $FunctionalProvider<
          PomodoroRepository,
          PomodoroRepository,
          PomodoroRepository
        >
    with $Provider<PomodoroRepository> {
  const PomodoroRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pomodoroRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pomodoroRepositoryHash();

  @$internal
  @override
  $ProviderElement<PomodoroRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PomodoroRepository create(Ref ref) {
    return pomodoroRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PomodoroRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PomodoroRepository>(value),
    );
  }
}

String _$pomodoroRepositoryHash() =>
    r'd01f5589f044d1b668ed21f8f7b61740b47e2270';
