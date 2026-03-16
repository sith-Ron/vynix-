import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quick_tools_provider.g.dart';

@riverpod
double currencyConvert(
  Ref ref, {
  required String pair,
  required double amount,
}) {
  final rate = switch (pair) {
    'USD_EUR' => 0.92,
    'EUR_USD' => 1.09,
    'USD_GBP' => 0.78,
    'GBP_USD' => 1.28,
    'USD_JPY' => 149.0,
    'JPY_USD' => 0.0067,
    _ => 1.0,
  };
  return amount * rate;
}

@riverpod
double bmi(Ref ref, {required double heightCm, required double weightKg}) {
  final heightM = heightCm / 100;
  if (heightM <= 0) {
    return 0;
  }
  return weightKg / (heightM * heightM);
}

@riverpod
class PasswordGenerator extends _$PasswordGenerator {
  static const _letters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const _numbers = '0123456789';
  static const _symbols = '!@#%^&*()-_=+[]{}';

  @override
  String build() => '';

  void generate({required int length, bool includeSymbols = true}) {
    final chars = includeSymbols
        ? '$_letters$_numbers$_symbols'
        : '$_letters$_numbers';
    final random = Random.secure();
    final generated = List.generate(
      length,
      (_) => chars[random.nextInt(chars.length)],
    ).join();
    state = generated;
  }
}
