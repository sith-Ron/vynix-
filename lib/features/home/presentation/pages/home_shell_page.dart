import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/core/providers/navigation_provider.dart';
import 'package:vynix/features/calendar/presentation/pages/calendar_page.dart';
import 'package:vynix/features/home/presentation/pages/home_dashboard_page.dart';
import 'package:vynix/features/notes/presentation/pages/notes_page.dart';
import 'package:vynix/features/pomodoro/presentation/pages/pomodoro_page.dart';
import 'package:vynix/features/todos/presentation/pages/todos_page.dart';
import 'package:vynix/shared/models/app_section.dart';

class HomeShellPage extends ConsumerWidget {
  const HomeShellPage({super.key});

  bool get _isCupertino {
    if (kIsWeb) {
      return false;
    }
    return Platform.isIOS || Platform.isMacOS;
  }

  static const List<AppSection> _sections = [
    AppSection(
      label: 'Home',
      icon: CupertinoIcons.house,
      page: HomeDashboardPage(),
    ),
    AppSection(
      label: 'Notes',
      icon: CupertinoIcons.doc_text,
      page: NotesPage(),
    ),
    AppSection(
      label: 'Calendar',
      icon: CupertinoIcons.calendar,
      page: CalendarPage(),
    ),
    AppSection(
      label: 'Tasks',
      icon: CupertinoIcons.checkmark_seal,
      page: TodosPage(),
    ),
    AppSection(
      label: 'Focus',
      icon: CupertinoIcons.timer,
      page: PomodoroPage(),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(homeNavigationIndexProvider);

    if (_isCupertino) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: index,
          onTap: (next) =>
              ref.read(homeNavigationIndexProvider.notifier).setIndex(next),
          items: _sections
              .map(
                (section) => BottomNavigationBarItem(
                  icon: Icon(section.icon),
                  label: section.label,
                ),
              )
              .toList(growable: false),
        ),
        tabBuilder: (context, tabIndex) {
          return _sections[tabIndex].page;
        },
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: index,
        children: _sections.map((s) => s.page).toList(growable: false),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (next) =>
            ref.read(homeNavigationIndexProvider.notifier).setIndex(next),
        destinations: _sections
            .map(
              (section) => NavigationDestination(
                icon: Icon(section.icon),
                label: section.label,
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}
