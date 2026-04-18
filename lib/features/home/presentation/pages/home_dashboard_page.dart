import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vynix/core/providers/navigation_provider.dart';
import 'package:vynix/core/theme/vynix_colors.dart';
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

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(sortedTodosProvider);
    final todayAgendaValue = ref.watch(homeTodayAgendaProvider);
    final pomodoro = ref.watch(pomodoroControllerProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
      title: 'VYNIX',
      trailing: IconButton(
        onPressed: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const SettingsPage())),
        icon: const Icon(CupertinoIcons.gear),
      ),
      body: CustomScrollView(
        slivers: [
          // Greeting & date header
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_greeting(), style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat.yMMMMEEEEd().format(DateTime.now()),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.labelMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stat cards row
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: CupertinoIcons.checkmark_circle,
                      iconColor: VynixColors.amber,
                      label: 'Pending',
                      value: '${pendingTodos.length}',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: CupertinoIcons.calendar,
                      iconColor: colorScheme.primary,
                      label: 'Events',
                      value: '${todayEvents.length}',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: CupertinoIcons.timer,
                      iconColor: VynixColors.success,
                      label: 'Focus',
                      value: focusClock,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Next Tasks section
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            sliver: SliverToBoxAdapter(
              child: VynixGlassCard(
                child: _SectionBlock(
                  icon: CupertinoIcons.checkmark_seal,
                  iconColor: VynixColors.amber,
                  title: 'Next Tasks',
                  emptyText: 'All clear — no pending tasks.',
                  actionLabel: 'View All',
                  onAction: () => ref
                      .read(homeNavigationIndexProvider.notifier)
                      .setIndex(3),
                  children: pendingTodos
                      .take(3)
                      .map(
                        (todo) => _TaskRow(
                          title: todo.title,
                          subtitle: todo.dueDate == null
                              ? null
                              : 'Due ${DateFormat.yMMMd().format(todo.dueDate!)}',
                          priority: todo.priority,
                        ),
                      )
                      .toList(growable: false),
                ),
              ),
            ),
          ),

          // Today's Calendar section
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            sliver: SliverToBoxAdapter(
              child: VynixGlassCard(
                child: todayAgendaValue.when(
                  data: (events) => _SectionBlock(
                    icon: CupertinoIcons.calendar,
                    iconColor: colorScheme.primary,
                    title: "Today's Schedule",
                    emptyText: 'No events scheduled for today.',
                    actionLabel: 'View All',
                    onAction: () => ref
                        .read(homeNavigationIndexProvider.notifier)
                        .setIndex(2),
                    children: events
                        .take(3)
                        .map(
                          (event) => _EventRow(
                            title: event.title,
                            time: event.isAllDay
                                ? 'All day'
                                : '${DateFormat.jm().format(event.startAt)} — ${DateFormat.jm().format(event.endAt)}',
                          ),
                        )
                        .toList(growable: false),
                  ),
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  ),
                  error: (error, _) =>
                      Text('Failed to load today events: $error'),
                ),
              ),
            ),
          ),

          // Focus Session — full interactive controls
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            sliver: SliverToBoxAdapter(
              child: _FocusSessionCard(
                pomodoro: pomodoro,
                focusClock: focusClock,
              ),
            ),
          ),

          // Quick Tools button
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const QuickToolsPage()),
                  ),
                  icon: const Icon(CupertinoIcons.square_grid_2x2, size: 18),
                  label: const Text('Quick Tools'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stat card with icon badge
// ---------------------------------------------------------------------------
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark
        ? VynixColors.darkBorder
        : VynixColors.lightBorder;
    final surfaceColor = isDark
        ? VynixColors.darkSurfaceElevated
        : VynixColors.lightSurfaceElevated;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Task row
// ---------------------------------------------------------------------------
class _TaskRow extends StatelessWidget {
  const _TaskRow({required this.title, this.subtitle, required this.priority});

  final String title;
  final String? subtitle;
  final TodoPriority priority;

  Color _priorityColor() {
    return switch (priority) {
      TodoPriority.high => VynixColors.coral,
      TodoPriority.medium => VynixColors.amber,
      TodoPriority.low => VynixColors.success,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 36,
            decoration: BoxDecoration(
              color: _priorityColor(),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null)
                  Text(subtitle!, style: theme.textTheme.labelMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Event row
// ---------------------------------------------------------------------------
class _EventRow extends StatelessWidget {
  const _EventRow({required this.title, required this.time});

  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 36,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(time, style: theme.textTheme.labelMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Focus session card — full interactive controls embedded in dashboard
// ---------------------------------------------------------------------------
class _FocusSessionCard extends ConsumerWidget {
  const _FocusSessionCard({required this.pomodoro, required this.focusClock});

  final PomodoroState pomodoro;
  final String focusClock;

  Future<void> _startWithModeSelection(
    BuildContext context,
    PomodoroController notifier,
  ) async {
    final mode = await showModalBottomSheet<FocusSessionMode>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(CupertinoIcons.timer),
                title: const Text('One-time session'),
                subtitle: const Text('Run one focus block, then stop.'),
                onTap: () =>
                    Navigator.of(sheetContext).pop(FocusSessionMode.oneTime),
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.repeat),
                title: const Text('Repeated sessions'),
                subtitle: const Text(
                  'Continue with breaks and next focus blocks.',
                ),
                onTap: () =>
                    Navigator.of(sheetContext).pop(FocusSessionMode.repeated),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (mode != null) {
      notifier.start(mode: mode);
    }
  }

  String _phaseLabel(PomodoroPhase phase) {
    return switch (phase) {
      PomodoroPhase.focus => 'Focus',
      PomodoroPhase.shortBreak => 'Short Break',
      PomodoroPhase.longBreak => 'Long Break',
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(pomodoroControllerProvider.notifier);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final phaseColor = pomodoro.running
        ? VynixColors.success
        : theme.colorScheme.outline;

    return VynixGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                CupertinoIcons.bolt_fill,
                size: 18,
                color: VynixColors.success,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Focus Session',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              if (pomodoro.running)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: VynixColors.success.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'ACTIVE',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: VynixColors.success,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Timer display
          Center(
            child: Column(
              children: [
                Text(
                  _phaseLabel(pomodoro.phase),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: phaseColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  focusClock,
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: pomodoro.running
                    ? notifier.pause
                    : () => _startWithModeSelection(context, notifier),
                icon: Icon(
                  pomodoro.running
                      ? CupertinoIcons.pause_fill
                      : CupertinoIcons.play_fill,
                  size: 18,
                ),
                label: Text(pomodoro.running ? 'Pause' : 'Start'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: notifier.reset,
                icon: const Icon(CupertinoIcons.refresh, size: 18),
                label: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Duration slider
          Row(
            children: [
              Expanded(
                child: Text(
                  'Focus: ${pomodoro.focusDurationMinutes} min',
                  style: theme.textTheme.bodySmall,
                ),
              ),
              Text(
                '${pomodoro.completedFocusSessions} sessions · ${(pomodoro.totalFocusSeconds / 60).toStringAsFixed(0)} min total',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isDark
                      ? VynixColors.darkSecondaryText
                      : VynixColors.lightSecondaryText,
                ),
              ),
            ],
          ),
          Slider.adaptive(
            min: 5,
            max: 120,
            divisions: 23,
            value: pomodoro.focusDurationMinutes.toDouble(),
            onChanged: pomodoro.running
                ? null
                : (value) => notifier.setFocusDurationMinutes(value.round()),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section block
// ---------------------------------------------------------------------------
class _SectionBlock extends StatelessWidget {
  const _SectionBlock({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.emptyText,
    required this.actionLabel,
    required this.onAction,
    required this.children,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String emptyText;
  final String actionLabel;
  final VoidCallback onAction;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final hasContent = children.isNotEmpty;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 8),
            Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
            TextButton(onPressed: onAction, child: Text(actionLabel)),
          ],
        ),
        if (hasContent)
          ...children
        else
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Text(
              emptyText,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.labelMedium?.color,
              ),
            ),
          ),
      ],
    );
  }
}
