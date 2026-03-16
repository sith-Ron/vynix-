import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/features/alarms/presentation/pages/alarms_page.dart';
import 'package:vynix/features/calculator/presentation/pages/calculator_page.dart';
import 'package:vynix/features/habits/presentation/pages/habits_page.dart';
import 'package:vynix/features/quick_tools/presentation/providers/quick_tools_provider.dart';
import 'package:vynix/features/settings/presentation/pages/settings_page.dart';
import 'package:vynix/features/voice_memos/presentation/pages/voice_memos_page.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class QuickToolsPage extends ConsumerStatefulWidget {
  const QuickToolsPage({super.key});

  @override
  ConsumerState<QuickToolsPage> createState() => _QuickToolsPageState();
}

class _QuickToolsPageState extends ConsumerState<QuickToolsPage> {
  final _currencyController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  String _currencyPair = 'USD_EUR';
  bool _includeSymbols = true;

  @override
  void dispose() {
    _currencyController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amount = double.tryParse(_currencyController.text) ?? 0;
    final converted = ref.watch(
      currencyConvertProvider(pair: _currencyPair, amount: amount),
    );

    final height = double.tryParse(_heightController.text) ?? 0;
    final weight = double.tryParse(_weightController.text) ?? 0;
    final bmi = ref.watch(bmiProvider(heightCm: height, weightKg: weight));
    final password = ref.watch(passwordGeneratorProvider);

    return AdaptiveSectionScaffold(
      title: 'Quick Tools',
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                VynixGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Currency Converter',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextField(
                        controller: _currencyController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(hintText: 'Amount'),
                        onChanged: (_) => setState(() {}),
                      ),
                      DropdownButtonFormField<String>(
                        initialValue: _currencyPair,
                        items: const [
                          DropdownMenuItem(
                            value: 'USD_EUR',
                            child: Text('USD -> EUR'),
                          ),
                          DropdownMenuItem(
                            value: 'EUR_USD',
                            child: Text('EUR -> USD'),
                          ),
                          DropdownMenuItem(
                            value: 'USD_GBP',
                            child: Text('USD -> GBP'),
                          ),
                          DropdownMenuItem(
                            value: 'GBP_USD',
                            child: Text('GBP -> USD'),
                          ),
                          DropdownMenuItem(
                            value: 'USD_JPY',
                            child: Text('USD -> JPY'),
                          ),
                          DropdownMenuItem(
                            value: 'JPY_USD',
                            child: Text('JPY -> USD'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _currencyPair = value);
                          }
                        },
                      ),
                      Text('Result: ${converted.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                VynixGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BMI Calculator',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextField(
                        controller: _heightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Height (cm)',
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      TextField(
                        controller: _weightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Weight (kg)',
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      Text('BMI: ${bmi.toStringAsFixed(1)}'),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                VynixGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password Generator',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Include symbols'),
                        value: _includeSymbols,
                        onChanged: (value) =>
                            setState(() => _includeSymbols = value),
                      ),
                      FilledButton(
                        onPressed: () => ref
                            .read(passwordGeneratorProvider.notifier)
                            .generate(
                              length: 16,
                              includeSymbols: _includeSymbols,
                            ),
                        child: const Text('Generate'),
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        password.isEmpty ? 'No password yet' : password,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                VynixGlassCard(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _navChip(context, 'Calculator', const CalculatorPage()),
                      _navChip(context, 'Alarms', const AlarmsPage()),
                      _navChip(context, 'Habits', const HabitsPage()),
                      _navChip(context, 'Voice Memos', const VoiceMemosPage()),
                      _navChip(context, 'Settings', const SettingsPage()),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navChip(BuildContext context, String label, Widget page) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute<void>(builder: (_) => page));
      },
    );
  }
}
