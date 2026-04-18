import 'package:flutter/widgets.dart';

@immutable
class AppSection {
  const AppSection({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.page,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final Widget page;
}
