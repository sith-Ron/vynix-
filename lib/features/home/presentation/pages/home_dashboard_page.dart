import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vynix/core/providers/navigation_provider.dart';
import 'package:vynix/features/calendar/domain/models/calendar_event_entry.dart';
import 'package:vynix/features/calendar/presentation/providers/calendar_providers.dart';
import 'package:vynix/features/pomodoro/presentation/providers/pomodoro_provider.dart';
import 'package:vynix/features/quick_tools/presentation/pages/quick_tools_page.dart';
import 'package:vynix/features/settings/presentation/pages/settings_page.dart';
import 'package:vynix/features/todos/presentation/providers/todos_provider.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

final homeTodayAgendaProvider = StreamProvider<List<CalendarEventEntry>>((ref) {
  final repo = ref.watch(calendarRepositoryProvider);
  return repo.watchDay(DateTime.now());
});

class HomeDashboardPage extends ConsumerWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(sortedTodosProvider);
    final todayAgendaValue = ref.watch(homeTodayAgendaProvider);
    final pomodoro = ref.watch(pomodoroControllerProvider);

    final pendingTodos = todos
        .where((todo) => !todo.isDone)
        .toList(growable: false);
    final todayEvents =
        todayAgendaValue.asData?.value ?? const <CalendarEventEntry>[];

    final focusMinutes = pomodoro.remaining.inMinutes;
    final focusSeconds = pomodoro.remaining.inSeconds.remainder(60);
    final focusClock =
        '${focusMinutes.toString().padLeft(2, '0')}:${focusSeconds.toString().padLeft(2, '0')}';

    return AdaptiveSectionScaffold(
      title: 'VYNIX+',
      trailing: IconButton(
        onPressed: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const SettingsPage())),
        icon: const Icon(CupertinoIcons.settings),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            sliver: SliverToBoxAdapter(
              child: VynixGlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMEEEEd().format(DateTime.now()),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _MetricTile(
                            label: 'Pending Tasks',
                            value: '${pendingTodos.length}',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _MetricTile(
                            label: 'Today Events',
                            value: '${todayEvents.length}',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _MetricTile(
                            label: 'Focus Left',
                            value: focusClock,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            sliver: SliverToBoxAdapter(
              child: VynixGlassCard(
                child: _SectionBlock(
                  title: 'Next Tasks',
                  emptyText: 'No pending tasks. You are all clear.',
                  actionLabel: 'Open Tasks',
                  onAction: () => ref
                      .read(homeNavigationIndexProvider.notifier)
                      .setIndex(3),
                  children: pendingTodos
                      .take(3)
                      .map(
                        (todo) => ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(CupertinoIcons.checkmark_circle),
                          title: Text(todo.title),
                          subtitle: todo.dueDate == null
                              ? null
                              : Text(
                                  'Due ${DateFormat.yMMMd().format(todo.dueDate!)}',
                                ),
                        ),
                      )
                      .toList(growable: false),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            sliver: SliverToBoxAdapter(
              child: VynixGlassCard(
                child: todayAgendaValue.when(
                  data: (events) => _SectionBlock(
                    title: 'Today Calendar',
                    emptyText: 'No events scheduled for today.',
                    actionLabel: 'Open Calendar',
                    onAction: () => ref
                        .read(homeNavigationIndexProvider.notifier)
                        .setIndex(2),
                    children: events
                        .take(3)
                        .map(
                          (event) => ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(CupertinoIcons.calendar),
                            title: Text(event.title),
                            subtitle: Text(
                              event.isAllDay
                                  ? 'All day'
                                  : '${DateFormat.jm().format(event.startAt)} - ${DateFormat.jm().format(event.endAt)}',
                            ),
                          ),
                        )
                        .toList(growable: false),
                  ),
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  ),
                  error: (error, _) =>
                      Text('Failed to load today events: $error'),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverToBoxAdapter(
              child: VynixGlassCard(
                child: _SectionBlock(
                  title: 'Focus Snapshot',
                  emptyText: '',
                  actionLabel: 'Open Focus',
                  onAction: () => ref
                      .read(homeNavigationIndexProvider.notifier)
                      .setIndex(4),
                  children: [
                    Text('Phase: ${_phaseLabel(pomodoro.phase)}'),
                    Text('Remaining: $focusClock'),
                    Text(
                      'Daily selected focus: ${pomodoro.focusDurationMinutes} min',
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const QuickToolsPage())),
              child: Center(
                child: Text(
                  'Access QUICK TOOLS',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _phaseLabel(PomodoroPhase phase) {
    return switch (phase) {
      PomodoroPhase.focus => 'Focus',
      PomodoroPhase.shortBreak => 'Short break',
      PomodoroPhase.longBreak => 'Long break',
    };
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({
    required this.title,
    required this.emptyText,
    required this.actionLabel,
    required this.onAction,
    required this.children,
  });

  final String title;
  final String emptyText;
  final String actionLabel;
  final VoidCallback onAction;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final hasContent = children.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            TextButton(onPressed: onAction, child: Text(actionLabel)),
          ],
        ),
        const SizedBox(height: 8),
        if (hasContent) ...children else Text(emptyText),
      ],
    );
  }
}
