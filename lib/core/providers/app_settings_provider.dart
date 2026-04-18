import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_settings_provider.g.dart';

enum NotificationSound {
  defaultSound('Default'),
  silent('Silent');

  const NotificationSound(this.label);
  final String label;
}

@immutable
class AppSettings {
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.locale,
    this.notificationsEnabled = true,
    this.notificationSound = NotificationSound.defaultSound,
    this.backupEnabled = false,
  });

  final ThemeMode themeMode;
  final Locale? locale;
  final bool notificationsEnabled;
  final NotificationSound notificationSound;
  final bool backupEnabled;

  AppSettings copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool clearLocale = false,
    bool? notificationsEnabled,
    NotificationSound? notificationSound,
    bool? backupEnabled,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      locale: clearLocale ? null : (locale ?? this.locale),
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      notificationSound: notificationSound ?? this.notificationSound,
      backupEnabled: backupEnabled ?? this.backupEnabled,
    );
  }
}

@riverpod
class AppSettingsController extends _$AppSettingsController {
  @override
  AppSettings build() => const AppSettings();

  void updateThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void updateLocale(Locale? locale) {
    if (locale == null) {
      state = state.copyWith(clearLocale: true);
      return;
    }

    state = state.copyWith(locale: locale);
  }

  void toggleNotifications(bool enabled) {
    state = state.copyWith(notificationsEnabled: enabled);
  }

  void updateNotificationSound(NotificationSound sound) {
    state = state.copyWith(notificationSound: sound);
  }

  void toggleBackup(bool enabled) {
    state = state.copyWith(backupEnabled: enabled);
  }
}
