import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/core/providers/navigation_provider.dart';
import 'package:vynix/core/theme/vynix_colors.dart';
import 'package:vynix/features/calculator/presentation/pages/calculator_page.dart';
import 'package:vynix/features/calendar/presentation/pages/calendar_page.dart';
import 'package:vynix/features/home/presentation/pages/home_dashboard_page.dart';
import 'package:vynix/features/notes/presentation/pages/notes_page.dart';
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
      activeIcon: CupertinoIcons.house_fill,
      page: HomeDashboardPage(),
    ),
    AppSection(
      label: 'Notes',
      icon: CupertinoIcons.doc_text,
      activeIcon: CupertinoIcons.doc_text_fill,
      page: NotesPage(),
    ),
    AppSection(
      label: 'Calendar',
      icon: CupertinoIcons.calendar,
      activeIcon: CupertinoIcons.calendar_today,
      page: CalendarPage(),
    ),
    AppSection(
      label: 'Tasks',
      icon: CupertinoIcons.checkmark_seal,
      activeIcon: CupertinoIcons.checkmark_seal_fill,
      page: TodosPage(),
    ),
    AppSection(
      label: 'Calc',
      icon: CupertinoIcons.plus_slash_minus,
      activeIcon: CupertinoIcons.plus_slash_minus,
      page: CalculatorPage(),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(homeNavigationIndexProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeColor = theme.colorScheme.primary;
    final inactiveColor = isDark
        ? VynixColors.darkSecondaryText
        : VynixColors.lightSecondaryText;

    if (_isCupertino) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: index,
          onTap: (next) =>
              ref.read(homeNavigationIndexProvider.notifier).setIndex(next),
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          backgroundColor: isDark
              ? VynixColors.darkSurface.withValues(alpha: 0.92)
              : VynixColors.lightSurface.withValues(alpha: 0.92),
          border: Border(
            top: BorderSide(
              color: isDark ? VynixColors.darkBorder : VynixColors.lightBorder,
              width: 0.5,
            ),
          ),
          iconSize: 22,
          items: _sections
              .map(
                (section) => BottomNavigationBarItem(
                  icon: Icon(section.icon),
                  activeIcon: Icon(section.activeIcon),
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
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark ? VynixColors.darkBorder : VynixColors.lightBorder,
              width: 0.5,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (next) =>
              ref.read(homeNavigationIndexProvider.notifier).setIndex(next),
          indicatorColor: activeColor.withValues(alpha: 0.12),
          destinations: _sections
              .map(
                (section) => NavigationDestination(
                  icon: Icon(section.icon, color: inactiveColor),
                  selectedIcon: Icon(section.activeIcon, color: activeColor),
                  label: section.label,
                ),
              )
              .toList(growable: false),
        ),
      ),
    );
  }
}
