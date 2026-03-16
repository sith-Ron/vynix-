import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vynix/core/theme/vynix_colors.dart';

class VynixGlassCard extends StatelessWidget {
  const VynixGlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.white).withValues(
              alpha: 0.12,
            ),
            blurRadius: 28,
            offset: const Offset(-6, -6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.34 : 0.08),
            blurRadius: 24,
            offset: const Offset(8, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color:
                  (isDark ? VynixColors.darkGlassSurface : colorScheme.surface)
                      .withValues(alpha: isDark ? 0.22 : 0.92),
              border: Border.all(
                color: isDark
                    ? colorScheme.primary.withValues(alpha: 0.16)
                    : VynixColors.lightShadow.withValues(alpha: 0.9),
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
