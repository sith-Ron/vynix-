import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/features/calculator/presentation/providers/calculator_provider.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class CalculatorPage extends ConsumerWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorControllerProvider);
    final notifier = ref.read(calculatorControllerProvider.notifier);

    return AdaptiveSectionScaffold(
      title: 'Calculator',
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                VynixGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        state.input,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.output,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _calcButton('7', () => notifier.append('7')),
                    _calcButton('8', () => notifier.append('8')),
                    _calcButton('9', () => notifier.append('9')),
                    _calcButton('/', () => notifier.append('/')),
                    _calcButton('4', () => notifier.append('4')),
                    _calcButton('5', () => notifier.append('5')),
                    _calcButton('6', () => notifier.append('6')),
                    _calcButton('x', () => notifier.append('*')),
                    _calcButton('1', () => notifier.append('1')),
                    _calcButton('2', () => notifier.append('2')),
                    _calcButton('3', () => notifier.append('3')),
                    _calcButton('-', () => notifier.append('-')),
                    _calcButton('0', () => notifier.append('0')),
                    _calcButton('.', () => notifier.append('.')),
                    _calcButton('(', () => notifier.append('(')),
                    _calcButton(')', () => notifier.append(')')),
                    _calcButton('+', () => notifier.append('+')),
                    _calcButton('sin(', () => notifier.append('sin(')),
                    _calcButton('cos(', () => notifier.append('cos(')),
                    _calcButton('tan(', () => notifier.append('tan(')),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: notifier.deleteLast,
                        child: const Text('DEL'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: notifier.clear,
                        child: const Text('C'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        onPressed: notifier.evaluate,
                        child: const Text('='),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                VynixGlassCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Memory: ${state.memory.toStringAsFixed(2)}'),
                      Wrap(
                        spacing: 6,
                        children: [
                          ActionChip(
                            label: const Text('M+'),
                            onPressed: notifier.memoryAdd,
                          ),
                          ActionChip(
                            label: const Text('M-'),
                            onPressed: notifier.memorySubtract,
                          ),
                          ActionChip(
                            label: const Text('MR'),
                            onPressed: notifier.memoryRecall,
                          ),
                          ActionChip(
                            label: const Text('MC'),
                            onPressed: notifier.memoryClear,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                VynixGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'History',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      if (state.history.isEmpty)
                        const Text('No calculations yet')
                      else
                        for (final item in state.history.take(8)) Text(item),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const _QuickUnitConverterCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: 72,
      child: OutlinedButton(onPressed: onPressed, child: Text(label)),
    );
  }
}

class _QuickUnitConverterCard extends ConsumerStatefulWidget {
  const _QuickUnitConverterCard();

  @override
  ConsumerState<_QuickUnitConverterCard> createState() =>
      _QuickUnitConverterCardState();
}

class _QuickUnitConverterCardState
    extends ConsumerState<_QuickUnitConverterCard> {
  final _inputController = TextEditingController();
  String _type = 'km_to_mi';

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = double.tryParse(_inputController.text) ?? 0;
    final result = ref.watch(unitConvertProvider(type: _type, value: value));

    return VynixGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unit Converter',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _inputController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(hintText: 'Value'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _type,
            items: const [
              DropdownMenuItem(value: 'km_to_mi', child: Text('KM to Miles')),
              DropdownMenuItem(value: 'mi_to_km', child: Text('Miles to KM')),
              DropdownMenuItem(value: 'kg_to_lb', child: Text('KG to LB')),
              DropdownMenuItem(value: 'lb_to_kg', child: Text('LB to KG')),
              DropdownMenuItem(value: 'c_to_f', child: Text('C to F')),
              DropdownMenuItem(value: 'f_to_c', child: Text('F to C')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _type = value);
              }
            },
          ),
          const SizedBox(height: 8),
          Text('Result: ${result.toStringAsFixed(4)}'),
        ],
      ),
    );
  }
}
