import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/features/habits/presentation/providers/habits_provider.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class HabitsPage extends ConsumerWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsControllerProvider);
    final stats = ref.watch(habitStatsProvider);

    return AdaptiveSectionScaffold(
      title: 'Habits',
      trailing: IconButton(
        onPressed: () => _showAddHabitDialog(context, ref),
        icon: const Icon(CupertinoIcons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            sliver: SliverToBoxAdapter(
              child: VynixGlassCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatTile(label: 'Habits', value: '${stats.totalHabits}'),
                    _StatTile(label: 'Today', value: '${stats.todayCompleted}'),
                    _StatTile(
                      label: 'Weekly',
                      value:
                          '${(stats.weeklyCompletionRate * 100).toStringAsFixed(0)}%',
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (habits.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('No habits yet. Tap + to create one.')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverList.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  final todayKey =
                      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
                  final doneToday = habit.completedDays.contains(todayKey);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: VynixGlassCard(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  habit.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Goal: ${habit.targetPerWeek} times/week',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => ref
                                .read(habitsControllerProvider.notifier)
                                .toggleToday(habit.id),
                            icon: Icon(
                              doneToday
                                  ? CupertinoIcons.checkmark_circle_fill
                                  : CupertinoIcons.circle,
                            ),
                          ),
                          IconButton(
                            onPressed: () => ref
                                .read(habitsControllerProvider.notifier)
                                .removeHabit(habit.id),
                            icon: const Icon(CupertinoIcons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showAddHabitDialog(BuildContext context, WidgetRef ref) async {
    final titleController = TextEditingController();
    double target = 4;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('New Habit'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: 'Habit name'),
                  ),
                  const SizedBox(height: 16),
                  Text('Weekly goal: ${target.toInt()}'),
                  Slider.adaptive(
                    min: 1,
                    max: 14,
                    divisions: 13,
                    value: target,
                    onChanged: (value) => setDialogState(() => target = value),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    ref
                        .read(habitsControllerProvider.notifier)
                        .addHabit(
                          title: titleController.text,
                          targetPerWeek: target.toInt(),
                        );
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Create'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}
