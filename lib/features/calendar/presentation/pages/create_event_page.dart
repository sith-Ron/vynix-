import 'dart:io' show Platform;

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vynix/features/calendar/domain/models/calendar_event_entry.dart';
import 'package:vynix/features/calendar/presentation/providers/calendar_providers.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class CalendarEventEditorPage extends ConsumerStatefulWidget {
  const CalendarEventEditorPage({
    super.key,
    required this.selectedDay,
    this.initialEvent,
  });

  final DateTime selectedDay;
  final CalendarEventEntry? initialEvent;

  @override
  ConsumerState<CalendarEventEditorPage> createState() =>
      _CalendarEventEditorPageState();
}

class _CalendarEventEditorPageState
    extends ConsumerState<CalendarEventEditorPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final String _draftId;

  bool get _isEditMode => widget.initialEvent != null;

  bool get _isCupertino {
    if (kIsWeb) {
      return false;
    }
    return Platform.isIOS || Platform.isMacOS;
  }

  @override
  void initState() {
    super.initState();
    _draftId =
        widget.initialEvent?.id.toString() ??
        'event-${DateTime.now().microsecondsSinceEpoch}';
    _titleController = TextEditingController(text: widget.initialEvent?.title);
    _descriptionController = TextEditingController(
      text: widget.initialEvent?.description,
    );

    final initialStart =
        widget.initialEvent?.startAt ??
        DateTime(
          widget.selectedDay.year,
          widget.selectedDay.month,
          widget.selectedDay.day,
          9,
        );
    final initialEnd =
        widget.initialEvent?.endAt ??
        initialStart.add(const Duration(hours: 1));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      ref
          .read(calendarEventDraftControllerProvider(_draftId).notifier)
          .seedFrom(
            startAt: initialStart,
            endAt: initialEnd,
            isAllDay: widget.initialEvent?.isAllDay ?? false,
            reminderMinutes: widget.initialEvent?.reminderMinutes,
          );
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(calendarEventDraftControllerProvider(_draftId));
    final mutation = ref.watch(calendarMutationsProvider);

    return AdaptiveSectionScaffold(
      title: _isEditMode ? 'Edit Event' : 'New Event',
      trailing: IconButton(
        tooltip: 'Save event',
        onPressed: mutation.isLoading ? null : () => _save(draft),
        icon: const Icon(CupertinoIcons.check_mark_circled_solid),
      ),
      body: CustomScrollView(
        slivers: [
          if (mutation.isLoading)
            const SliverToBoxAdapter(
              child: LinearProgressIndicator(minHeight: 2),
            ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                VynixGlassCard(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Event title',
                    ),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 12),
                VynixGlassCard(
                  child: TextField(
                    controller: _descriptionController,
                    minLines: 3,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description / notes',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                VynixGlassCard(
                  child: Column(
                    children: [
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('All-day event'),
                        value: draft.isAllDay,
                        onChanged: ref
                            .read(
                              calendarEventDraftControllerProvider(
                                _draftId,
                              ).notifier,
                            )
                            .setAllDay,
                      ),
                      const Divider(height: 20),
                      _DateRow(
                        label: 'Starts',
                        value: draft.startAt,
                        isAllDay: draft.isAllDay,
                        onTap: () => _pickDateTime(
                          initial: draft.startAt,
                          onValue: ref
                              .read(
                                calendarEventDraftControllerProvider(
                                  _draftId,
                                ).notifier,
                              )
                              .setStart,
                          isAllDay: draft.isAllDay,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _DateRow(
                        label: 'Ends',
                        value: draft.endAt,
                        isAllDay: draft.isAllDay,
                        onTap: () => _pickDateTime(
                          initial: draft.endAt,
                          onValue: ref
                              .read(
                                calendarEventDraftControllerProvider(
                                  _draftId,
                                ).notifier,
                              )
                              .setEnd,
                          isAllDay: draft.isAllDay,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                VynixGlassCard(
                  child: DropdownButtonFormField<int?>(
                    initialValue: draft.reminderMinutes,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Reminder',
                    ),
                    items: const [
                      DropdownMenuItem<int?>(
                        value: null,
                        child: Text('No reminder'),
                      ),
                      DropdownMenuItem<int?>(
                        value: 5,
                        child: Text('5 minutes before'),
                      ),
                      DropdownMenuItem<int?>(
                        value: 10,
                        child: Text('10 minutes before'),
                      ),
                      DropdownMenuItem<int?>(
                        value: 15,
                        child: Text('15 minutes before'),
                      ),
                      DropdownMenuItem<int?>(
                        value: 30,
                        child: Text('30 minutes before'),
                      ),
                      DropdownMenuItem<int?>(
                        value: 60,
                        child: Text('1 hour before'),
                      ),
                      DropdownMenuItem<int?>(
                        value: 1440,
                        child: Text('1 day before'),
                      ),
                    ],
                    onChanged: ref
                        .read(
                          calendarEventDraftControllerProvider(
                            _draftId,
                          ).notifier,
                        )
                        .setReminderMinutes,
                  ),
                ),
                if (_isEditMode) ...[
                  const SizedBox(height: 14),
                  TextButton.icon(
                    onPressed: mutation.isLoading ? null : _delete,
                    icon: const Icon(CupertinoIcons.trash),
                    label: const Text('Delete event'),
                  ),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDateTime({
    required DateTime initial,
    required ValueChanged<DateTime> onValue,
    required bool isAllDay,
  }) async {
    if (_isCupertino) {
      DateTime pickerValue = initial;
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (popupContext) {
          return Container(
            color: Theme.of(context).colorScheme.surface,
            height: 300,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    onPressed: () => Navigator.of(popupContext).pop(),
                    child: const Text('Done'),
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: isAllDay
                        ? CupertinoDatePickerMode.date
                        : CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: initial,
                    onDateTimeChanged: (value) => pickerValue = value,
                  ),
                ),
              ],
            ),
          );
        },
      );
      onValue(pickerValue);
      return;
    }

    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (!mounted) {
      return;
    }
    if (date == null) {
      return;
    }

    if (isAllDay) {
      onValue(DateTime(date.year, date.month, date.day));
      return;
    }

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (!mounted) {
      return;
    }
    if (time == null) {
      return;
    }

    onValue(DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  Future<void> _save(CalendarEventDraft draft) async {
    await ref
        .read(calendarMutationsProvider.notifier)
        .save(
          existing: widget.initialEvent,
          title: _titleController.text,
          description: _descriptionController.text,
          startAt: draft.startAt,
          endAt: draft.endAt,
          isAllDay: draft.isAllDay,
          reminderMinutes: draft.reminderMinutes,
        );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    final existing = widget.initialEvent;
    if (existing == null) {
      return;
    }

    final result = await showOkCancelAlertDialog(
      context: context,
      title: 'Delete event?',
      message: 'This action cannot be undone.',
      okLabel: 'Delete',
      isDestructiveAction: true,
    );

    if (result != OkCancelResult.ok) {
      return;
    }

    await ref.read(calendarMutationsProvider.notifier).remove(existing.id);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}

class _DateRow extends StatelessWidget {
  const _DateRow({
    required this.label,
    required this.value,
    required this.isAllDay,
    required this.onTap,
  });

  final String label;
  final DateTime value;
  final bool isAllDay;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat.yMMMEd().format(value);
    final timeText = isAllDay ? 'All-day' : DateFormat.jm().format(value);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: Text('$dateText - $timeText'),
      trailing: const Icon(CupertinoIcons.chevron_right),
      onTap: onTap,
    );
  }
}
