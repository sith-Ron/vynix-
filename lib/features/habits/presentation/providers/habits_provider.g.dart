// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habits_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HabitsController)
const habitsControllerProvider = HabitsControllerProvider._();

final class HabitsControllerProvider
    extends $NotifierProvider<HabitsController, List<HabitItem>> {
  const HabitsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitsControllerHash();

  @$internal
  @override
  HabitsController create() => HabitsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<HabitItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<HabitItem>>(value),
    );
  }
}

String _$habitsControllerHash() => r'51bf37b6fdf28d1e288d909f007820c21b3d7647';

abstract class _$HabitsController extends $Notifier<List<HabitItem>> {
  List<HabitItem> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<HabitItem>, List<HabitItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<HabitItem>, List<HabitItem>>,
              List<HabitItem>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(habitsRepository)
const habitsRepositoryProvider = HabitsRepositoryProvider._();

final class HabitsRepositoryProvider
    extends
        $FunctionalProvider<
          HabitsRepository,
          HabitsRepository,
          HabitsRepository
        >
    with $Provider<HabitsRepository> {
  const HabitsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitsRepositoryHash();

  @$internal
  @override
  $ProviderElement<HabitsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HabitsRepository create(Ref ref) {
    return habitsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HabitsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HabitsRepository>(value),
    );
  }
}

String _$habitsRepositoryHash() => r'bd26db5d7b8bd05123e166d31db89c092ce11dcb';

@ProviderFor(habitStats)
const habitStatsProvider = HabitStatsProvider._();

final class HabitStatsProvider
    extends $FunctionalProvider<HabitStats, HabitStats, HabitStats>
    with $Provider<HabitStats> {
  const HabitStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitStatsHash();

  @$internal
  @override
  $ProviderElement<HabitStats> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HabitStats create(Ref ref) {
    return habitStats(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HabitStats value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HabitStats>(value),
    );
  }
}

String _$habitStatsHash() => r'410a238429c139328d3f783662e9415ffb629b38';
