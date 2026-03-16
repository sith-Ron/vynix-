import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/features/alarms/presentation/providers/alarms_provider.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class AlarmsPage extends ConsumerWidget {
  const AlarmsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarms = ref.watch(alarmsControllerProvider);

    return AdaptiveSectionScaffold(
      title: 'Alarms & Clock',
      trailing: IconButton(
        onPressed: () => _showAddAlarmDialog(context, ref),
        icon: const Icon(CupertinoIcons.add),
      ),
      body: CustomScrollView(
        slivers: [
          if (alarms.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('No alarms yet. Tap + to create one.')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              sliver: SliverList.builder(
                itemCount: alarms.length,
                itemBuilder: (context, index) {
                  final alarm = alarms[index];
                  final recurringLabel = alarm.recurringWeekdays.isEmpty
                      ? 'Daily'
                      : (() {
                          final sorted = alarm.recurringWeekdays.toList()
                            ..sort();
                          return sorted.join(', ');
                        })();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: VynixGlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${alarm.hour.toString().padLeft(2, '0')}:${alarm.minute.toString().padLeft(2, '0')}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                              ),
                              Switch.adaptive(
                                value: alarm.enabled,
                                onChanged: (_) => ref
                                    .read(alarmsControllerProvider.notifier)
                                    .toggleEnabled(alarm.id),
                              ),
                            ],
                          ),
                          Text(alarm.label),
                          const SizedBox(height: 6),
                          Text('Recurring: $recurringLabel'),
                          Text('Snooze: ${alarm.snoozeMinutes} min'),
                          Text('Vibration: ${alarm.vibration ? 'On' : 'Off'}'),
                          Text('Sound: ${alarm.sound ? 'On' : 'Off'}'),
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () => ref
                                    .read(alarmsControllerProvider.notifier)
                                    .snooze(alarm.id),
                                icon: const Icon(
                                  CupertinoIcons.refresh_circled,
                                ),
                                label: const Text('Snooze now'),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () => ref
                                    .read(alarmsControllerProvider.notifier)
                                    .removeAlarm(alarm.id),
                                icon: const Icon(CupertinoIcons.delete),
                              ),
                            ],
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

  Future<void> _showAddAlarmDialog(BuildContext context, WidgetRef ref) async {
    final labelController = TextEditingController();
    TimeOfDay time = TimeOfDay.now();
    final selectedWeekdays = <int>{};
    double snooze = 10;
    bool vibration = true;
    bool sound = true;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('New alarm'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: labelController,
                      decoration: const InputDecoration(hintText: 'Label'),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Time ${time.format(context)}'),
                      trailing: const Icon(CupertinoIcons.clock),
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: time,
                        );
                        if (picked != null) {
                          setDialogState(() => time = picked);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: List.generate(7, (index) {
                        final day = index + 1;
                        const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                        return FilterChip(
                          selected: selectedWeekdays.contains(day),
                          label: Text(labels[index]),
                          onSelected: (selected) {
                            setDialogState(() {
                              if (selected) {
                                selectedWeekdays.add(day);
                              } else {
                                selectedWeekdays.remove(day);
                              }
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text('Snooze ${snooze.toInt()} min'),
                    Slider.adaptive(
                      min: 5,
                      max: 30,
                      divisions: 5,
                      value: snooze,
                      onChanged: (value) =>
                          setDialogState(() => snooze = value),
                    ),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Vibration'),
                      value: vibration,
                      onChanged: (value) =>
                          setDialogState(() => vibration = value),
                    ),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Sound'),
                      value: sound,
                      onChanged: (value) => setDialogState(() => sound = value),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () async {
                    await ref
                        .read(alarmsControllerProvider.notifier)
                        .addAlarm(
                          hour: time.hour,
                          minute: time.minute,
                          label: labelController.text,
                          recurringWeekdays: selectedWeekdays,
                          snoozeMinutes: snooze.toInt(),
                          vibration: vibration,
                          sound: sound,
                        );
                    if (context.mounted) {
                      Navigator.of(dialogContext).pop();
                    }
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
