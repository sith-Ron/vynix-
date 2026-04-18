// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widget_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeWidgetService)
const homeWidgetServiceProvider = HomeWidgetServiceProvider._();

final class HomeWidgetServiceProvider
    extends
        $FunctionalProvider<
          HomeWidgetService,
          HomeWidgetService,
          HomeWidgetService
        >
    with $Provider<HomeWidgetService> {
  const HomeWidgetServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeWidgetServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeWidgetServiceHash();

  @$internal
  @override
  $ProviderElement<HomeWidgetService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeWidgetService create(Ref ref) {
    return homeWidgetService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeWidgetService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeWidgetService>(value),
    );
  }
}

String _$homeWidgetServiceHash() => r'87c7ddc111cfd079aeb47962f80a3c3ddd1b0638';

/// Watches todos, today's calendar events, and pomodoro state, then pushes
/// the latest stats to the native home-screen / lock-screen widget.

@ProviderFor(homeWidgetSync)
const homeWidgetSyncProvider = HomeWidgetSyncProvider._();

/// Watches todos, today's calendar events, and pomodoro state, then pushes
/// the latest stats to the native home-screen / lock-screen widget.

final class HomeWidgetSyncProvider extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Watches todos, today's calendar events, and pomodoro state, then pushes
  /// the latest stats to the native home-screen / lock-screen widget.
  const HomeWidgetSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeWidgetSyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeWidgetSyncHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return homeWidgetSync(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$homeWidgetSyncHash() => r'e0e70da485f3910c70aa053cddd80aedb778d4d5';
