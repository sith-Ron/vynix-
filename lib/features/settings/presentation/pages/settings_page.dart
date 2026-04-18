import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/core/providers/app_settings_provider.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsControllerProvider);
    final notifier = ref.read(appSettingsControllerProvider.notifier);

    return AdaptiveSectionScaffold(
      title: 'Settings',
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                VynixGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Theme',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<ThemeMode>(
                        initialValue: settings.themeMode,
                        items: const [
                          DropdownMenuItem(
                            value: ThemeMode.system,
                            child: Text('System'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.light,
                            child: Text('Light'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.dark,
                            child: Text('Dark'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            notifier.updateThemeMode(value);
                          }
                        },
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
                        'Language',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<Locale?>(
                        initialValue: settings.locale,
                        items: const [
                          DropdownMenuItem<Locale?>(
                            value: null,
                            child: Text('System default'),
                          ),
                          DropdownMenuItem<Locale?>(
                            value: Locale('en'),
                            child: Text('English'),
                          ),
                          DropdownMenuItem<Locale?>(
                            value: Locale('es'),
                            child: Text('Spanish'),
                          ),
                          DropdownMenuItem<Locale?>(
                            value: Locale('fr'),
                            child: Text('French'),
                          ),
                        ],
                        onChanged: notifier.updateLocale,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                VynixGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Notifications'),
                        value: settings.notificationsEnabled,
                        onChanged: notifier.toggleNotifications,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButtonFormField<NotificationSound>(
                          initialValue: settings.notificationSound,
                          decoration: const InputDecoration(
                            labelText: 'Notification sound',
                          ),
                          items: NotificationSound.values
                              .map(
                                (sound) => DropdownMenuItem(
                                  value: sound,
                                  child: Text(sound.label),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              notifier.updateNotificationSound(value);
                            }
                          },
                        ),
                      ),
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Backup'),
                        value: settings.backupEnabled,
                        onChanged: notifier.toggleBackup,
                      ),
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
