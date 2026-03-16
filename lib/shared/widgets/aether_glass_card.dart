import 'dart:ui';

import 'package:flutter/material.dart';

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

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: (brightness == Brightness.dark ? Colors.black : Colors.white)
                .withValues(alpha: 0.14),
            blurRadius: 28,
            offset: const Offset(-6, -6),
          ),
          BoxShadow(
            color: Colors.black.withValues(
              alpha: brightness == Brightness.dark ? 0.38 : 0.1,
            ),
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
              color: colorScheme.surface.withValues(
                alpha: brightness == Brightness.dark ? 0.56 : 0.72,
              ),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.16),
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
