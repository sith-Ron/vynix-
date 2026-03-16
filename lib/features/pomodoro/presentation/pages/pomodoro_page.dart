import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/features/pomodoro/presentation/providers/pomodoro_provider.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class PomodoroPage extends ConsumerWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pomodoroControllerProvider);
    final notifier = ref.read(pomodoroControllerProvider.notifier);

    final minutes = state.remaining.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = state.remaining.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    final phaseText = switch (state.phase) {
      PomodoroPhase.focus => 'Focus',
      PomodoroPhase.shortBreak => 'Short Break',
      PomodoroPhase.longBreak => 'Long Break',
    };

    return AdaptiveSectionScaffold(
      title: 'Pomodoro',
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                VynixGlassCard(
                  child: Column(
                    children: [
                      Text(
                        phaseText,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '$minutes:$seconds',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton.icon(
                            onPressed: state.running
                                ? notifier.pause
                                : notifier.start,
                            icon: Icon(
                              state.running
                                  ? CupertinoIcons.pause_fill
                                  : CupertinoIcons.play_fill,
                            ),
                            label: Text(state.running ? 'Pause' : 'Start'),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton.icon(
                            onPressed: notifier.reset,
                            icon: const Icon(CupertinoIcons.refresh),
                            label: const Text('Reset'),
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
                        'Statistics',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Completed focus sessions: ${state.completedFocusSessions}',
                      ),
                      Text(
                        'Total focus minutes: ${(state.totalFocusSeconds / 60).toStringAsFixed(1)}',
                      ),
                      Text('Cycles: ${state.cycles}'),
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
}
