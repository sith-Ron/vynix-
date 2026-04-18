import 'package:flutter/material.dart';

abstract final class VynixColors {
  // Backgrounds
  static const Color lightBackground = Color(0xFFF5F6FA);
  static const Color darkBackground = Color(0xFF0D1117);

  // Surfaces
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkSurface = Color(0xFF161B22);
  static const Color darkGlassSurface = Color(0xFF1C2128);

  // Elevated surface (cards, sheets)
  static const Color lightSurfaceElevated = Color(0xFFFFFFFF);
  static const Color darkSurfaceElevated = Color(0xFF1E242C);

  // Text
  static const Color lightPrimaryText = Color(0xFF1A1D26);
  static const Color darkPrimaryText = Color(0xFFE6EDF3);
  static const Color lightSecondaryText = Color(0xFF656D76);
  static const Color darkSecondaryText = Color(0xFF8B949E);

  // Accents
  static const Color lightAccent = Color(0xFF6366F1);
  static const Color darkAccent = Color(0xFF818CF8);
  static const Color lightAccentSecondary = Color(0xFF0EA5E9);
  static const Color darkAccentSecondary = Color(0xFF38BDF8);

  // Semantic colors
  static const Color success = Color(0xFF22C55E);
  static const Color amber = Color(0xFFF59E0B);
  static const Color coral = Color(0xFFEF4444);
  static const Color pink = Color(0xFFEC4899);

  // Borders & shadows
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color darkBorder = Color(0xFF30363D);
  static const Color lightShadow = Color(0xFFE2E8F0);
  static const Color darkShadow = Color(0xFF010409);
}
