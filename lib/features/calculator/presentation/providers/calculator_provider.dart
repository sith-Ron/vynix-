import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:math_expressions/math_expressions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vynix/core/providers/database_provider.dart';
import 'package:vynix/features/calculator/data/repositories/calculator_repository.dart';
import 'package:vynix/shared/services/database/app_database.dart';

part 'calculator_provider.g.dart';

@immutable
class CalculatorState {
  const CalculatorState({
    this.input = '',
    this.output = '0',
    this.memory = 0,
    this.history = const <String>[],
  });

  final String input;
  final String output;
  final double memory;
  final List<String> history;

  CalculatorState copyWith({
    String? input,
    String? output,
    double? memory,
    List<String>? history,
  }) {
    return CalculatorState(
      input: input ?? this.input,
      output: output ?? this.output,
      memory: memory ?? this.memory,
      history: history ?? this.history,
    );
  }
}

@riverpod
class CalculatorController extends _$CalculatorController {
  StreamSubscription<CalculatorPrefRecord>? _prefsSub;
  StreamSubscription<List<CalculatorHistoryRecord>>? _historySub;
  List<String> _historyCache = const [];

  @override
  CalculatorState build() {
    if (_prefsSub == null) {
      final repo = ref.read(calculatorRepositoryProvider);
      _prefsSub = repo.watchPrefs().listen((prefs) {
        state = state.copyWith(
          input: prefs.input,
          output: prefs.output,
          memory: prefs.memory,
          history: _historyCache,
        );
      });
      _historySub = repo.watchHistory().listen((rows) {
        _historyCache = rows.map((row) => row.item).toList(growable: false);
        state = state.copyWith(history: _historyCache);
      });
      ref.onDispose(() {
        _prefsSub?.cancel();
        _historySub?.cancel();
      });
    }

    return const CalculatorState();
  }

  void append(String value) {
    state = state.copyWith(input: '${state.input}$value');
    unawaited(_persistPrefs());
  }

  void clear() {
    state = state.copyWith(input: '', output: '0');
    unawaited(_persistPrefs());
  }

  void deleteLast() {
    if (state.input.isEmpty) {
      return;
    }
    state = state.copyWith(
      input: state.input.substring(0, state.input.length - 1),
    );
    unawaited(_persistPrefs());
  }

  void evaluate() {
    final expression = state.input.trim();
    if (expression.isEmpty) {
      return;
    }

    try {
      final parser = Parser();
      final exp = parser.parse(expression);
      final result = exp.evaluate(EvaluationType.REAL, ContextModel());
      final raw = result.toStringAsFixed(8);
      final out = raw.replaceFirst(RegExp(r'\.?0+$'), '');
      state = state.copyWith(
        output: out,
        history: ['${state.input} = $out', ...state.history].take(20).toList(),
      );
      unawaited(
        ref
            .read(calculatorRepositoryProvider)
            .addHistory('${state.input} = $out'),
      );
      unawaited(_persistPrefs());
    } catch (_) {
      state = state.copyWith(output: 'Error');
      unawaited(_persistPrefs());
    }
  }

  void memoryAdd() {
    state = state.copyWith(
      memory: state.memory + (double.tryParse(state.output) ?? 0),
    );
    unawaited(_persistPrefs());
  }

  void memorySubtract() {
    state = state.copyWith(
      memory: state.memory - (double.tryParse(state.output) ?? 0),
    );
    unawaited(_persistPrefs());
  }

  void memoryClear() {
    state = state.copyWith(memory: 0);
    unawaited(_persistPrefs());
  }

  void memoryRecall() {
    state = state.copyWith(input: '${state.input}${state.memory}');
    unawaited(_persistPrefs());
  }

  Future<void> _persistPrefs() {
    return ref
        .read(calculatorRepositoryProvider)
        .savePrefs(
          input: state.input,
          output: state.output,
          memory: state.memory,
        );
  }
}

@riverpod
double unitConvert(Ref ref, {required String type, required double value}) {
  return switch (type) {
    'km_to_mi' => value * 0.621371,
    'mi_to_km' => value / 0.621371,
    'kg_to_lb' => value * 2.20462,
    'lb_to_kg' => value / 2.20462,
    'c_to_f' => (value * 9 / 5) + 32,
    'f_to_c' => (value - 32) * 5 / 9,
    _ => value,
  };
}

@riverpod
CalculatorRepository calculatorRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return CalculatorRepository(db);
}
