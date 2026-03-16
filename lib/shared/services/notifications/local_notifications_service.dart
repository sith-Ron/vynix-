import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
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

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

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

  Future<void> syncCalendarReminder(CalendarEventEntry event) async {
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
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _calendarChannelId,
          _calendarChannelName,
          channelDescription: _calendarChannelDescription,
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
        ),
        iOS: DarwinNotificationDetails(),
        macOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
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
  }) async {
    await initialize();
    await cancelAlarm(alarmId);

    if (weekdays.isEmpty) {
      final next = _nextDateForTime(hour: hour, minute: minute);
      await _plugin.zonedSchedule(
        _alarmNotificationId(alarmId, 0),
        title,
        body,
        next,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _alarmsChannelId,
            _alarmsChannelName,
            channelDescription: _alarmsChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
            playSound: sound,
            enableVibration: vibration,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentSound: sound,
          ),
          macOS: DarwinNotificationDetails(
            presentAlert: true,
            presentSound: sound,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
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
        NotificationDetails(
          android: AndroidNotificationDetails(
            _alarmsChannelId,
            _alarmsChannelName,
            channelDescription: _alarmsChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
            playSound: sound,
            enableVibration: vibration,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentSound: sound,
          ),
          macOS: DarwinNotificationDetails(
            presentAlert: true,
            presentSound: sound,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
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
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _alarmsChannelId,
          _alarmsChannelName,
          channelDescription: _alarmsChannelDescription,
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
        ),
        iOS: DarwinNotificationDetails(),
        macOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'alarm_snooze:$alarmId',
    );
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
