// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_tools_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currencyConvert)
const currencyConvertProvider = CurrencyConvertFamily._();

final class CurrencyConvertProvider
    extends $FunctionalProvider<double, double, double>
    with $Provider<double> {
  const CurrencyConvertProvider._({
    required CurrencyConvertFamily super.from,
    required ({String pair, double amount}) super.argument,
  }) : super(
         retry: null,
         name: r'currencyConvertProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currencyConvertHash();

  @override
  String toString() {
    return r'currencyConvertProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<double> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double create(Ref ref) {
    final argument = this.argument as ({String pair, double amount});
    return currencyConvert(ref, pair: argument.pair, amount: argument.amount);
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
    return other is CurrencyConvertProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currencyConvertHash() => r'571d9129314d7b92e05aee97e44685a7a669170e';

final class CurrencyConvertFamily extends $Family
    with $FunctionalFamilyOverride<double, ({String pair, double amount})> {
  const CurrencyConvertFamily._()
    : super(
        retry: null,
        name: r'currencyConvertProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CurrencyConvertProvider call({
    required String pair,
    required double amount,
  }) => CurrencyConvertProvider._(
    argument: (pair: pair, amount: amount),
    from: this,
  );

  @override
  String toString() => r'currencyConvertProvider';
}

@ProviderFor(bmi)
const bmiProvider = BmiFamily._();

final class BmiProvider extends $FunctionalProvider<double, double, double>
    with $Provider<double> {
  const BmiProvider._({
    required BmiFamily super.from,
    required ({double heightCm, double weightKg}) super.argument,
  }) : super(
         retry: null,
         name: r'bmiProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bmiHash();

  @override
  String toString() {
    return r'bmiProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<double> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double create(Ref ref) {
    final argument = this.argument as ({double heightCm, double weightKg});
    return bmi(ref, heightCm: argument.heightCm, weightKg: argument.weightKg);
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
    return other is BmiProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bmiHash() => r'2d803455408886e942880ff13b112e3edf8cc600';

final class BmiFamily extends $Family
    with
        $FunctionalFamilyOverride<
          double,
          ({double heightCm, double weightKg})
        > {
  const BmiFamily._()
    : super(
        retry: null,
        name: r'bmiProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BmiProvider call({required double heightCm, required double weightKg}) =>
      BmiProvider._(
        argument: (heightCm: heightCm, weightKg: weightKg),
        from: this,
      );

  @override
  String toString() => r'bmiProvider';
}

@ProviderFor(PasswordGenerator)
const passwordGeneratorProvider = PasswordGeneratorProvider._();

final class PasswordGeneratorProvider
    extends $NotifierProvider<PasswordGenerator, String> {
  const PasswordGeneratorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passwordGeneratorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passwordGeneratorHash();

  @$internal
  @override
  PasswordGenerator create() => PasswordGenerator();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$passwordGeneratorHash() => r'4c38934c4909d9467193cfcfa7ebd83a2200d21e';

abstract class _$PasswordGenerator extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
