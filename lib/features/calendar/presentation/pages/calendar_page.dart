import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vynix/features/calendar/domain/models/calendar_event_entry.dart';
import 'package:vynix/features/calendar/presentation/pages/create_event_page.dart';
import 'package:vynix/features/calendar/presentation/providers/calendar_providers.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(calendarVisibleMonthProvider);
    final selectedDay = ref.watch(calendarSelectedDayProvider);
    final monthEvents = ref.watch(calendarMonthEventsProvider);
    final agenda = ref.watch(calendarDayAgendaProvider);
    final monthTitle = DateFormat.yMMMM().format(month);

    return AdaptiveSectionScaffold(
      title: 'Calendar',
      trailing: IconButton(
        tooltip: 'Add event',
        onPressed: () => _openEventEditor(context, selectedDay: selectedDay),
        icon: const Icon(CupertinoIcons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            sliver: SliverToBoxAdapter(
              child: VynixGlassCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          tooltip: 'Previous month',
                          onPressed: ref
                              .read(calendarVisibleMonthProvider.notifier)
                              .previousMonth,
                          icon: const Icon(CupertinoIcons.chevron_left),
                        ),
                        Expanded(
                          child: Text(
                            monthTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        IconButton(
                          tooltip: 'Next month',
                          onPressed: ref
                              .read(calendarVisibleMonthProvider.notifier)
                              .nextMonth,
                          icon: const Icon(CupertinoIcons.chevron_right),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    monthEvents.when(
                      data: (events) => _MonthGrid(
                        month: month,
                        selectedDay: selectedDay,
                        events: events,
                        onSelectDay: (day) {
                          ref
                              .read(calendarSelectedDayProvider.notifier)
                              .setDay(day);
                          ref
                              .read(calendarVisibleMonthProvider.notifier)
                              .setMonth(day);
                        },
                      ),
                      loading: () => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      error: (error, _) => Text(
                        'Failed to load month: $error',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Agenda - ${DateFormat.yMMMEd().format(selectedDay)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          agenda.when(
            data: (events) {
              if (events.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: VynixGlassCard(
                      child: Text(
                        'No events for this day. Tap + to create one.',
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverList.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _AgendaCard(
                        event: event,
                        onTap: () => _openEventEditor(
                          context,
                          selectedDay: selectedDay,
                          event: event,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(child: CircularProgressIndicator.adaptive()),
              ),
            ),
            error: (error, _) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Failed to load agenda: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openEventEditor(
    BuildContext context, {
    required DateTime selectedDay,
    CalendarEventEntry? event,
  }) async {
    final route = Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoPageRoute<void>(
            builder: (_) => CalendarEventEditorPage(
              selectedDay: selectedDay,
              initialEvent: event,
            ),
          )
        : MaterialPageRoute<void>(
            builder: (_) => CalendarEventEditorPage(
              selectedDay: selectedDay,
              initialEvent: event,
            ),
          );

    await Navigator.of(context).push(route);
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.selectedDay,
    required this.events,
    required this.onSelectDay,
  });

  final DateTime month;
  final DateTime selectedDay;
  final List<CalendarEventEntry> events;
  final ValueChanged<DateTime> onSelectDay;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(month.year, month.month, 1);
    final firstWeekdayOffset = firstDay.weekday % 7;
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final totalCells = ((firstWeekdayOffset + daysInMonth + 6) ~/ 7) * 7;

    final eventsByDay = <DateTime, int>{};
    for (final event in events) {
      final key = DateTime(
        event.startAt.year,
        event.startAt.month,
        event.startAt.day,
      );
      eventsByDay.update(key, (count) => count + 1, ifAbsent: () => 1);
    }

    const weekdayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Column(
      children: [
        Row(
          children: weekdayNames
              .map(
                (name) => Expanded(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              )
              .toList(growable: false),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          itemCount: totalCells,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
          ),
          itemBuilder: (context, index) {
            final dayNumber = index - firstWeekdayOffset + 1;
            final isActiveDay = dayNumber > 0 && dayNumber <= daysInMonth;

            if (!isActiveDay) {
              return const SizedBox.shrink();
            }

            final day = DateTime(month.year, month.month, dayNumber);
            final isSelected =
                day.year == selectedDay.year &&
                day.month == selectedDay.month &&
                day.day == selectedDay.day;
            final count = eventsByDay[day] ?? 0;

            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onSelectDay(day),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected
                      ? Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.2)
                      : Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.08),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$dayNumber',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (count > 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '$count',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AgendaCard extends StatelessWidget {
  const _AgendaCard({required this.event, required this.onTap});

  final CalendarEventEntry event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dateFormat = event.isAllDay ? null : DateFormat.jm();
    final timeText = event.isAllDay
        ? 'All-day'
        : '${dateFormat!.format(event.startAt)} - ${dateFormat.format(event.endAt)}';
    final reminderText = event.reminderMinutes == null
        ? 'No reminder'
        : 'Reminder ${event.reminderMinutes} min before';

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: VynixGlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(timeText, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(reminderText, style: Theme.of(context).textTheme.labelMedium),
            if (event.description.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                event.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
