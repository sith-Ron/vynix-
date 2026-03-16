import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_settings_provider.g.dart';

@immutable
class AppSettings {
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.locale,
    this.notificationsEnabled = true,
    this.backupEnabled = false,
  });

  final ThemeMode themeMode;
  final Locale? locale;
  final bool notificationsEnabled;
  final bool backupEnabled;

  AppSettings copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool clearLocale = false,
    bool? notificationsEnabled,
    bool? backupEnabled,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      locale: clearLocale ? null : (locale ?? this.locale),
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
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

  void toggleBackup(bool enabled) {
    state = state.copyWith(backupEnabled: enabled);
  }
}
