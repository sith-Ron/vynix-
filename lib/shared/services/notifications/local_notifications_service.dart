import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:vynix/core/providers/app_settings_provider.dart';
import 'package:vynix/features/calendar/domain/models/calendar_event_entry.dart';

class LocalNotificationsService {
  LocalNotificationsService._();

  static final LocalNotificationsService instance =
      LocalNotificationsService._();

  static const String _calendarChannelId = 'calendar_reminders';
  static const String _calendarChannelName = 'Calendar Reminders';
  static const String _calendarChannelDescription =
      'Scheduled reminders for calendar events';
  static const String _alarmsChannelId = 'alarms';
  static const String _alarmsChannelName = 'Alarms';
  static const String _alarmsChannelDescription =
      'Scheduled alarm notifications';
  static const String _focusChannelId = 'focus_sessions';
  static const String _focusChannelName = 'Focus Sessions';
  static const String _focusChannelDescription =
      'Notifications for completed focus sessions';
  static const String _todosChannelId = 'todo_reminders';
  static const String _todosChannelName = 'Task Reminders';
  static const String _todosChannelDescription =
      'Reminders for upcoming task deadlines';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<AndroidScheduleMode> _bestEffortScheduleMode() async {
    final androidImplementation = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (androidImplementation == null) {
      return AndroidScheduleMode.exactAllowWhileIdle;
    }

    try {
      final canExact =
          await androidImplementation.canScheduleExactNotifications() ?? false;
      return canExact
          ? AndroidScheduleMode.exactAllowWhileIdle
          : AndroidScheduleMode.inexactAllowWhileIdle;
    } catch (_) {
      return AndroidScheduleMode.inexactAllowWhileIdle;
    }
  }

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    tz.initializeTimeZones();
    await _configureLocalTimezone();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _plugin.initialize(settings);

    final androidImplementation = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidImplementation?.requestNotificationsPermission();
    await androidImplementation?.requestExactAlarmsPermission();

    final iOSImplementation = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    await iOSImplementation?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    _initialized = true;
  }

  Future<void> syncCalendarReminder(
    CalendarEventEntry event, {
    NotificationSound notificationSound = NotificationSound.defaultSound,
  }) async {
    await initialize();

    final notificationId = _calendarReminderNotificationId(event.id);
    await _plugin.cancel(notificationId);

    final reminderMinutes = event.reminderMinutes;
    if (reminderMinutes == null) {
      return;
    }

    final triggerAt = event.startAt.subtract(
      Duration(minutes: reminderMinutes),
    );
    if (triggerAt.isBefore(DateTime.now())) {
      return;
    }

    final body = event.description.trim().isEmpty
        ? 'Event starts at ${_formatTime(event.startAt)}'
        : event.description.trim();

    await _plugin.zonedSchedule(
      notificationId,
      event.title,
      body,
      tz.TZDateTime.from(triggerAt, tz.local),
      _notificationDetails(
        channelId: _calendarChannelId,
        channelName: _calendarChannelName,
        channelDescription: _calendarChannelDescription,
        soundEnabled: notificationSound != NotificationSound.silent,
      ),
      androidScheduleMode: await _bestEffortScheduleMode(),
      payload: 'calendar_event:${event.id}',
    );
  }

  Future<void> cancelCalendarReminder(int eventId) async {
    await initialize();
    await _plugin.cancel(_calendarReminderNotificationId(eventId));
  }

  Future<void> syncAlarm({
    required int alarmId,
    required String title,
    required String body,
    required int hour,
    required int minute,
    required Set<int> weekdays,
    required bool vibration,
    required bool sound,
    NotificationSound notificationSound = NotificationSound.defaultSound,
  }) async {
    await initialize();
    await cancelAlarm(alarmId);

    final shouldPlaySound =
        sound && notificationSound != NotificationSound.silent;
    if (weekdays.isEmpty) {
      final next = _nextDateForTime(hour: hour, minute: minute);
      await _plugin.zonedSchedule(
        _alarmNotificationId(alarmId, 0),
        title,
        body,
        next,
        _notificationDetails(
          channelId: _alarmsChannelId,
          channelName: _alarmsChannelName,
          channelDescription: _alarmsChannelDescription,
          soundEnabled: shouldPlaySound,
          enableVibration: vibration,
          presentAlert: true,
        ),
        androidScheduleMode: await _bestEffortScheduleMode(),
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'alarm:$alarmId',
      );
      return;
    }

    for (final weekday in weekdays) {
      final next = _nextDateForWeekday(
        hour: hour,
        minute: minute,
        weekday: weekday,
      );
      await _plugin.zonedSchedule(
        _alarmNotificationId(alarmId, weekday),
        title,
        body,
        next,
        _notificationDetails(
          channelId: _alarmsChannelId,
          channelName: _alarmsChannelName,
          channelDescription: _alarmsChannelDescription,
          soundEnabled: shouldPlaySound,
          enableVibration: vibration,
          presentAlert: true,
        ),
        androidScheduleMode: await _bestEffortScheduleMode(),
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: 'alarm:$alarmId:$weekday',
      );
    }
  }

  Future<void> cancelAlarm(int alarmId) async {
    await initialize();
    for (var day = 0; day <= 7; day++) {
      await _plugin.cancel(_alarmNotificationId(alarmId, day));
    }
  }

  Future<void> snoozeAlarm({
    required int alarmId,
    required String title,
    required String body,
    required int snoozeMinutes,
    NotificationSound notificationSound = NotificationSound.defaultSound,
  }) async {
    await initialize();
    final triggerAt = tz.TZDateTime.now(
      tz.local,
    ).add(Duration(minutes: snoozeMinutes));
    await _plugin.zonedSchedule(
      _alarmNotificationId(alarmId, 99),
      title,
      body,
      triggerAt,
      _notificationDetails(
        channelId: _alarmsChannelId,
        channelName: _alarmsChannelName,
        channelDescription: _alarmsChannelDescription,
        soundEnabled: notificationSound != NotificationSound.silent,
        enableVibration: true,
      ),
      androidScheduleMode: await _bestEffortScheduleMode(),
      payload: 'alarm_snooze:$alarmId',
    );
  }

  Future<void> notifyFocusSessionCompleted({
    required bool repeated,
    required int completedSessions,
    NotificationSound notificationSound = NotificationSound.defaultSound,
  }) async {
    await initialize();
    await _plugin.show(
      300001,
      'Focus session complete',
      repeated
          ? 'Great work. Break started. Sessions done: $completedSessions.'
          : 'Great work. Your one-time focus session is complete.',
      _notificationDetails(
        channelId: _focusChannelId,
        channelName: _focusChannelName,
        channelDescription: _focusChannelDescription,
        soundEnabled: notificationSound != NotificationSound.silent,
        enableVibration: true,
      ),
      payload: 'focus_session_complete',
    );
  }

  Future<void> scheduleFocusSessionCompletion({
    required Duration after,
    required bool repeated,
    required int completedSessions,
    NotificationSound notificationSound = NotificationSound.defaultSound,
  }) async {
    await initialize();
    await cancelFocusSessionCompletion();

    if (after <= Duration.zero) {
      return;
    }

    final triggerAt = tz.TZDateTime.now(tz.local).add(after);
    await _plugin.zonedSchedule(
      300001,
      'Focus session complete',
      repeated
          ? 'Great work. Break starts next. Sessions done: $completedSessions.'
          : 'Great work. Your one-time focus session is complete.',
      triggerAt,
      _notificationDetails(
        channelId: _focusChannelId,
        channelName: _focusChannelName,
        channelDescription: _focusChannelDescription,
        soundEnabled: notificationSound != NotificationSound.silent,
        enableVibration: true,
      ),
      androidScheduleMode: await _bestEffortScheduleMode(),
      payload: 'focus_session_complete',
    );
  }

  Future<void> cancelFocusSessionCompletion() async {
    await initialize();
    await _plugin.cancel(300001);
  }

  Future<void> scheduleTodoReminder({
    required String todoId,
    required String title,
    required DateTime dueDate,
    NotificationSound notificationSound = NotificationSound.defaultSound,
  }) async {
    await initialize();
    final notificationId = _todoReminderNotificationId(todoId);
    await _plugin.cancel(notificationId);

    // Remind 30 minutes before noon on the due date.
    final triggerAt = DateTime(dueDate.year, dueDate.month, dueDate.day, 9, 0);
    if (triggerAt.isBefore(DateTime.now())) {
      return;
    }

    await _plugin.zonedSchedule(
      notificationId,
      'Task due today',
      title,
      tz.TZDateTime.from(triggerAt, tz.local),
      _notificationDetails(
        channelId: _todosChannelId,
        channelName: _todosChannelName,
        channelDescription: _todosChannelDescription,
        soundEnabled: notificationSound != NotificationSound.silent,
        enableVibration: true,
      ),
      androidScheduleMode: await _bestEffortScheduleMode(),
      payload: 'todo:$todoId',
    );
  }

  Future<void> cancelTodoReminder(String todoId) async {
    await initialize();
    await _plugin.cancel(_todoReminderNotificationId(todoId));
  }

  Future<void> _configureLocalTimezone() async {
    try {
      final timezoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneName));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
  }

  int _calendarReminderNotificationId(int eventId) => 100000 + eventId;

  int _alarmNotificationId(int alarmId, int variant) =>
      200000 + (alarmId * 10) + variant;

  int _todoReminderNotificationId(String todoId) =>
      400000 + (todoId.hashCode.abs() % 99999);

  tz.TZDateTime _nextDateForTime({required int hour, required int minute}) {
    final now = tz.TZDateTime.now(tz.local);
    var target = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (target.isBefore(now)) {
      target = target.add(const Duration(days: 1));
    }
    return target;
  }

  NotificationDetails _notificationDetails({
    required String channelId,
    required String channelName,
    required String channelDescription,
    required bool soundEnabled,
    bool enableVibration = true,
    bool presentAlert = false,
  }) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: channelDescription,
        importance: Importance.high,
        priority: Priority.high,
        playSound: soundEnabled,
        enableVibration: enableVibration,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: presentAlert,
        presentSound: soundEnabled,
      ),
      macOS: DarwinNotificationDetails(
        presentAlert: presentAlert,
        presentSound: soundEnabled,
      ),
    );
  }

  tz.TZDateTime _nextDateForWeekday({
    required int hour,
    required int minute,
    required int weekday,
  }) {
    var target = _nextDateForTime(hour: hour, minute: minute);
    while (target.weekday != weekday) {
      target = target.add(const Duration(days: 1));
    }
    return target;
  }

  String _formatTime(DateTime value) {
    final hour = value.hour % 12 == 0 ? 12 : value.hour % 12;
    final minute = value.minute.toString().padLeft(2, '0');
    final suffix = value.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $suffix';
  }
}
