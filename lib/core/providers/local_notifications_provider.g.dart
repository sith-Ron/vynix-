// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_notifications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localNotificationsService)
const localNotificationsServiceProvider = LocalNotificationsServiceProvider._();

final class LocalNotificationsServiceProvider
    extends
        $FunctionalProvider<
          LocalNotificationsService,
          LocalNotificationsService,
          LocalNotificationsService
        >
    with $Provider<LocalNotificationsService> {
  const LocalNotificationsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localNotificationsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localNotificationsServiceHash();

  @$internal
  @override
  $ProviderElement<LocalNotificationsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalNotificationsService create(Ref ref) {
    return localNotificationsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalNotificationsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalNotificationsService>(value),
    );
  }
}

String _$localNotificationsServiceHash() =>
    r'0ef6361a66f24d37b953ffc917e969fe160fd462';
