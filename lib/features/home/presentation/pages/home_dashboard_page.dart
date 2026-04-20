import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vynix/core/providers/navigation_provider.dart';
import 'package:vynix/core/theme/vynix_colors.dart';
import 'package:vynix/features/calendar/domain/models/calendar_event_entry.dart';
import 'package:vynix/features/calendar/presentation/providers/calendar_providers.dart';
import 'package:vynix/features/pomodoro/presentation/providers/pomodoro_provider.dart';
import 'package:vynix/features/settings/presentation/pages/settings_page.dart';
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
    final todayAgendaValue = ref.watch(homeTodayAgendaProvider);
    final pomodoro = ref.watch(pomodoroControllerProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final todayEvents =
        todayAgendaValue.asData?.value ?? const <CalendarEventEntry>[];

    final focusMinutes = pomodoro.remaining.inMinutes;
    final focusSeconds = pomodoro.remaining.inSeconds.remainder(60);
    final focusClock =
        '${focusMinutes.toString().padLeft(2, '0')}:${focusSeconds.toString().padLeft(2, '0')}';

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          // Elegant Header with Action Button
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                child: IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  ),
                  icon: Icon(
                    CupertinoIcons.gear_alt,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            VynixColors.darkBackground,
                            colorScheme.primary.withValues(alpha: 0.15),
                            VynixColors.darkBackground,
                          ]
                        : [
                            VynixColors.lightBackground,
                            colorScheme.primary.withValues(alpha: 0.08),
                            VynixColors.lightBackground,
                          ],
                  ),
                ),
                padding: const EdgeInsets.only(left: 24, bottom: 16),
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _greeting(),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateFormat.yMMMMEEEEd().format(DateTime.now()),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.labelMedium?.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Overview Stats
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: CupertinoIcons.calendar,
                      iconColor: colorScheme.primary,
                      label: "Today's Events",
                      value: '${todayEvents.length}',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      icon: CupertinoIcons.clock,
                      iconColor: VynixColors.success,
                      label: "Current Date",
                      value: DateFormat.d().format(DateTime.now()),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Focus Session
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            sliver: SliverToBoxAdapter(
              child: _FocusSessionCard(
                pomodoro: pomodoro,
                focusClock: focusClock,
              ),
            ),
          ),

          // Today's Calendar Card
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              24,
              0,
              24,
              120,
            ), // Bottom padding for content
            sliver: SliverToBoxAdapter(
              child: VynixGlassCard(
                child: todayAgendaValue.when(
                  data: (events) => _SectionBlock(
                    icon: CupertinoIcons.calendar_circle_fill,
                    iconColor: colorScheme.primary,
                    title: "Schedule",
                    emptyText: 'You have a clear day today.',
                    actionLabel: 'Open',
                    onAction: () => ref
                        .read(homeNavigationIndexProvider.notifier)
                        .setIndex(2), // Calendar tab index
                    children: events
                        .take(5)
                        .map(
                          (event) => _EventRow(
                            title: event.title,
                            time: event.isAllDay
                                ? 'All day'
                                : '${DateFormat.jm().format(event.startAt)} — ${DateFormat.jm().format(event.endAt)}',
                            color: colorScheme.primary,
                          ),
                        )
                        .toList(growable: false),
                  ),
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  ),
                  error: (error, _) => Text('Failed to load schedule: $error'),
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
// Stat card with gradient background and icon
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

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  VynixColors.darkSurfaceElevated,
                  VynixColors.darkSurfaceElevated.withValues(alpha: 0.5),
                ]
              : [VynixColors.lightSurfaceElevated, VynixColors.lightBackground],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: (isDark ? VynixColors.darkBorder : VynixColors.lightBorder)
              .withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : VynixColors.lightShadow).withValues(
              alpha: 0.05,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 22, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
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
  const _EventRow({
    required this.title,
    required this.time,
    required this.color,
  });

  final String title;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
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

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24, color: iconColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              FilledButton.tonal(
                onPressed: onAction,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  minimumSize: const Size(0, 36),
                ),
                child: Text(
                  actionLabel,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (hasContent)
            ...children
          else
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  emptyText,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.textTheme.labelMedium?.color,
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
// Focus session card
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
              Icon(CupertinoIcons.bolt_fill, size: 18, color: phaseColor),
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
        ],
      ),
    );
  }
}
