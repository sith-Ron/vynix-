import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vynix/core/theme/vynix_colors.dart';

abstract final class VynixTheme {
  static ThemeData light() {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: VynixColors.lightAccent,
          brightness: Brightness.light,
        ).copyWith(
          primary: VynixColors.lightAccent,
          onPrimary: Colors.black,
          secondary: VynixColors.lightAccentSecondary,
          onSecondary: Colors.white,
          error: VynixColors.coral,
          onError: Colors.white,
          surface: VynixColors.lightSurface,
          onSurface: VynixColors.lightPrimaryText,
          outline: VynixColors.lightShadow,
          surfaceContainerHighest: VynixColors.lightSurface,
        );

    return _baseTheme(scheme).copyWith(
      scaffoldBackgroundColor: VynixColors.lightBackground,
      dividerColor: VynixColors.lightShadow,
      cardTheme: const CardThemeData(
        color: VynixColors.lightSurface,
        elevation: 0,
      ),
    );
  }

  static ThemeData dark() {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: VynixColors.darkAccent,
          brightness: Brightness.dark,
        ).copyWith(
          primary: VynixColors.darkAccent,
          onPrimary: Colors.black,
          secondary: VynixColors.darkAccentSecondary,
          onSecondary: Colors.black,
          error: VynixColors.coral,
          onError: Colors.black,
          surface: VynixColors.darkSurface,
          onSurface: VynixColors.darkPrimaryText,
          outline: VynixColors.darkSecondaryText.withValues(alpha: 0.28),
          surfaceContainerHighest: VynixColors.darkSurface,
        );

    return _baseTheme(scheme).copyWith(
      scaffoldBackgroundColor: VynixColors.darkBackground,
      dividerColor: VynixColors.darkSecondaryText.withValues(alpha: 0.32),
      cardTheme: const CardThemeData(
        color: VynixColors.darkSurface,
        elevation: 0,
      ),
    );
  }

  static ThemeData _baseTheme(ColorScheme colorScheme) {
    final baseTextTheme = GoogleFonts.manropeTextTheme();
    final themedText = baseTextTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: GoogleFonts.manrope().fontFamily,
      textTheme: themedText,
      primaryTextTheme: themedText,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
        },
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: 72,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.18),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.w600),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.onSurface.withValues(alpha: 0.65);
        }),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        thumbColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.onSurface.withValues(alpha: 0.2),
      ),
      chipTheme: ChipThemeData(
        selectedColor: colorScheme.primary.withValues(alpha: 0.18),
        backgroundColor: colorScheme.surface,
        side: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.14)),
        labelStyle: themedText.labelMedium,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: themedText.bodyMedium?.copyWith(
          color: colorScheme.brightness == Brightness.dark
              ? VynixColors.darkSecondaryText
              : VynixColors.lightSecondaryText,
        ),
      ),
    );
  }
}
