import 'package:flutter/material.dart';
import 'package:vynix/core/theme/vynix_colors.dart';

class VynixGlassCard extends StatelessWidget {
  const VynixGlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.accentColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    final borderColor = isDark
        ? VynixColors.darkBorder
        : VynixColors.lightBorder;
    final surfaceColor = isDark
        ? VynixColors.darkSurfaceElevated
        : VynixColors.lightSurfaceElevated;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: accentColor != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: accentColor!, width: 3),
                  ),
                ),
                position: DecorationPosition.foreground,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: child,
                ),
              ),
            )
          : child,
    );
  }
}
