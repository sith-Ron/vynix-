// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CalculatorController)
const calculatorControllerProvider = CalculatorControllerProvider._();

final class CalculatorControllerProvider
    extends $NotifierProvider<CalculatorController, CalculatorState> {
  const CalculatorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calculatorControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calculatorControllerHash();

  @$internal
  @override
  CalculatorController create() => CalculatorController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalculatorState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalculatorState>(value),
    );
  }
}

String _$calculatorControllerHash() =>
    r'497e3c0a7aa84d13f884e1109104d73494c7e9cb';

abstract class _$CalculatorController extends $Notifier<CalculatorState> {
  CalculatorState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CalculatorState, CalculatorState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CalculatorState, CalculatorState>,
              CalculatorState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(unitConvert)
const unitConvertProvider = UnitConvertFamily._();

final class UnitConvertProvider
    extends $FunctionalProvider<double, double, double>
    with $Provider<double> {
  const UnitConvertProvider._({
    required UnitConvertFamily super.from,
    required ({String type, double value}) super.argument,
  }) : super(
         retry: null,
         name: r'unitConvertProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$unitConvertHash();

  @override
  String toString() {
    return r'unitConvertProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<double> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double create(Ref ref) {
    final argument = this.argument as ({String type, double value});
    return unitConvert(ref, type: argument.type, value: argument.value);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UnitConvertProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$unitConvertHash() => r'746c2202935420e80dca0b3f564774ce82b0a094';

final class UnitConvertFamily extends $Family
    with $FunctionalFamilyOverride<double, ({String type, double value})> {
  const UnitConvertFamily._()
    : super(
        retry: null,
        name: r'unitConvertProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UnitConvertProvider call({required String type, required double value}) =>
      UnitConvertProvider._(argument: (type: type, value: value), from: this);

  @override
  String toString() => r'unitConvertProvider';
}

@ProviderFor(calculatorRepository)
const calculatorRepositoryProvider = CalculatorRepositoryProvider._();

final class CalculatorRepositoryProvider
    extends
        $FunctionalProvider<
          CalculatorRepository,
          CalculatorRepository,
          CalculatorRepository
        >
    with $Provider<CalculatorRepository> {
  const CalculatorRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calculatorRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calculatorRepositoryHash();

  @$internal
  @override
  $ProviderElement<CalculatorRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CalculatorRepository create(Ref ref) {
    return calculatorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalculatorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalculatorRepository>(value),
    );
  }
}

String _$calculatorRepositoryHash() =>
    r'8a9a37d5d21fe7a68c3d3207b3769b35884dc00b';
