// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarms_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AlarmsController)
const alarmsControllerProvider = AlarmsControllerProvider._();

final class AlarmsControllerProvider
    extends $NotifierProvider<AlarmsController, List<AlarmItem>> {
  const AlarmsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alarmsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alarmsControllerHash();

  @$internal
  @override
  AlarmsController create() => AlarmsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AlarmItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AlarmItem>>(value),
    );
  }
}

String _$alarmsControllerHash() => r'e411c61cae6b0c4c2c4dbe345b6fdd2c00ad4f28';

abstract class _$AlarmsController extends $Notifier<List<AlarmItem>> {
  List<AlarmItem> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<AlarmItem>, List<AlarmItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<AlarmItem>, List<AlarmItem>>,
              List<AlarmItem>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(alarmsRepository)
const alarmsRepositoryProvider = AlarmsRepositoryProvider._();

final class AlarmsRepositoryProvider
    extends
        $FunctionalProvider<
          AlarmsRepository,
          AlarmsRepository,
          AlarmsRepository
        >
    with $Provider<AlarmsRepository> {
  const AlarmsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alarmsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alarmsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AlarmsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AlarmsRepository create(Ref ref) {
    return alarmsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AlarmsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AlarmsRepository>(value),
    );
  }
}

String _$alarmsRepositoryHash() => r'e1f9ee7ddc67b55e695b2463a2c57c2e5a01d792';
