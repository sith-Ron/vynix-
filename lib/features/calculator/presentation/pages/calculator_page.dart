import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/core/theme/vynix_colors.dart';
import 'package:vynix/features/calculator/presentation/providers/calculator_provider.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class CalculatorPage extends ConsumerWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorControllerProvider);
    final notifier = ref.read(calculatorControllerProvider.notifier);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AdaptiveSectionScaffold(
      title: 'Calculator',
      trailing: IconButton(
        icon: const Icon(CupertinoIcons.clock),
        tooltip: 'History',
        onPressed: () => _showHistory(context, state.history),
      ),
      body: Column(
        children: [
          // Display area
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: VynixGlassCard(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Memory indicator
                  if (state.memory != 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'M: ${_formatNumber(state.memory)}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  // Input expression
                  Text(
                    state.input.isEmpty ? ' ' : state.input,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDark
                          ? VynixColors.darkSecondaryText
                          : VynixColors.lightSecondaryText,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Output result
                  Text(
                    state.output,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Memory row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _MemoryChip(label: 'MC', onTap: notifier.memoryClear),
                const SizedBox(width: 8),
                _MemoryChip(label: 'MR', onTap: notifier.memoryRecall),
                const SizedBox(width: 8),
                _MemoryChip(label: 'M+', onTap: notifier.memoryAdd),
                const SizedBox(width: 8),
                _MemoryChip(label: 'M−', onTap: notifier.memorySubtract),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Keypad grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: _Keypad(notifier: notifier, isDark: isDark),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double n) {
    final s = n.toStringAsFixed(8).replaceFirst(RegExp(r'\.?0+$'), '');
    return s;
  }

  void _showHistory(BuildContext context, List<String> history) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('History', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              if (history.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'No calculations yet',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.labelMedium?.color,
                      ),
                    ),
                  ),
                )
              else
                ...history
                    .take(10)
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          item,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Memory chip button
// ---------------------------------------------------------------------------
class _MemoryChip extends StatelessWidget {
  const _MemoryChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: theme.colorScheme.outline),
            ),
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Keypad grid
// ---------------------------------------------------------------------------
class _Keypad extends StatelessWidget {
  const _Keypad({required this.notifier, required this.isDark});

  final CalculatorController notifier;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryText = isDark
        ? VynixColors.darkSecondaryText
        : VynixColors.lightSecondaryText;

    // Row definitions: [label, action, type]
    // type: 'num' | 'op' | 'fn' | 'action' | 'equals'
    final rows = <List<_KeyDef>>[
      [
        _KeyDef('sin', () => notifier.append('sin('), _KeyType.fn),
        _KeyDef('cos', () => notifier.append('cos('), _KeyType.fn),
        _KeyDef('tan', () => notifier.append('tan('), _KeyType.fn),
        _KeyDef('(  )', () => notifier.append('('), _KeyType.fn),
      ],
      [
        _KeyDef('C', notifier.clear, _KeyType.action),
        _KeyDef('⌫', notifier.deleteLast, _KeyType.action),
        _KeyDef('%', () => notifier.append('/100'), _KeyType.op),
        _KeyDef('÷', () => notifier.append('/'), _KeyType.op),
      ],
      [
        _KeyDef('7', () => notifier.append('7'), _KeyType.num),
        _KeyDef('8', () => notifier.append('8'), _KeyType.num),
        _KeyDef('9', () => notifier.append('9'), _KeyType.num),
        _KeyDef('×', () => notifier.append('*'), _KeyType.op),
      ],
      [
        _KeyDef('4', () => notifier.append('4'), _KeyType.num),
        _KeyDef('5', () => notifier.append('5'), _KeyType.num),
        _KeyDef('6', () => notifier.append('6'), _KeyType.num),
        _KeyDef('−', () => notifier.append('-'), _KeyType.op),
      ],
      [
        _KeyDef('1', () => notifier.append('1'), _KeyType.num),
        _KeyDef('2', () => notifier.append('2'), _KeyType.num),
        _KeyDef('3', () => notifier.append('3'), _KeyType.num),
        _KeyDef('+', () => notifier.append('+'), _KeyType.op),
      ],
      [
        _KeyDef(')', () => notifier.append(')'), _KeyType.fn),
        _KeyDef('0', () => notifier.append('0'), _KeyType.num),
        _KeyDef('.', () => notifier.append('.'), _KeyType.num),
        _KeyDef('=', notifier.evaluate, _KeyType.equals),
      ],
    ];

    return Column(
      children: rows.map((row) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: row.map((key) {
                final isLast = key == row.last;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: isLast ? 0 : 8),
                    child: _CalcKey(
                      label: key.label,
                      onTap: key.onTap,
                      type: key.type,
                      isDark: isDark,
                      theme: theme,
                      secondaryText: secondaryText,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }).toList(),
    );
  }
}

enum _KeyType { num, op, fn, action, equals }

class _KeyDef {
  const _KeyDef(this.label, this.onTap, this.type);
  final String label;
  final VoidCallback onTap;
  final _KeyType type;
}

class _CalcKey extends StatelessWidget {
  const _CalcKey({
    required this.label,
    required this.onTap,
    required this.type,
    required this.isDark,
    required this.theme,
    required this.secondaryText,
  });

  final String label;
  final VoidCallback onTap;
  final _KeyType type;
  final bool isDark;
  final ThemeData theme;
  final Color secondaryText;

  @override
  Widget build(BuildContext context) {
    final Color bgColor;
    final Color fgColor;

    switch (type) {
      case _KeyType.equals:
        bgColor = theme.colorScheme.primary;
        fgColor = theme.colorScheme.onPrimary;
      case _KeyType.op:
        bgColor = theme.colorScheme.primary.withValues(alpha: 0.12);
        fgColor = theme.colorScheme.primary;
      case _KeyType.action:
        bgColor = VynixColors.coral.withValues(alpha: 0.10);
        fgColor = VynixColors.coral;
      case _KeyType.fn:
        bgColor = isDark
            ? VynixColors.darkSurfaceElevated
            : VynixColors.lightBackground;
        fgColor = secondaryText;
      case _KeyType.num:
        bgColor = isDark ? VynixColors.darkSurface : VynixColors.lightSurface;
        fgColor = theme.colorScheme.onSurface;
    }

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: type == _KeyType.num
                ? Border.all(
                    color: isDark
                        ? VynixColors.darkBorder
                        : VynixColors.lightBorder,
                  )
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: type == _KeyType.equals ? 24 : 18,
              fontWeight: type == _KeyType.num
                  ? FontWeight.w500
                  : FontWeight.w600,
              color: fgColor,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Unit Converter section — accessed from Quick Tools or bottom of calc
// ---------------------------------------------------------------------------
class QuickUnitConverterCard extends ConsumerStatefulWidget {
  const QuickUnitConverterCard({super.key});

  @override
  ConsumerState<QuickUnitConverterCard> createState() =>
      _QuickUnitConverterCardState();
}

class _QuickUnitConverterCardState
    extends ConsumerState<QuickUnitConverterCard> {
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
    final theme = Theme.of(context);

    return VynixGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Unit Converter', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          TextField(
            controller: _inputController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(hintText: 'Enter value'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            initialValue: _type,
            items: const [
              DropdownMenuItem(value: 'km_to_mi', child: Text('KM → Miles')),
              DropdownMenuItem(value: 'mi_to_km', child: Text('Miles → KM')),
              DropdownMenuItem(value: 'kg_to_lb', child: Text('KG → LB')),
              DropdownMenuItem(value: 'lb_to_kg', child: Text('LB → KG')),
              DropdownMenuItem(value: 'c_to_f', child: Text('°C → °F')),
              DropdownMenuItem(value: 'f_to_c', child: Text('°F → °C')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _type = value);
              }
            },
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              result.toStringAsFixed(4),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
