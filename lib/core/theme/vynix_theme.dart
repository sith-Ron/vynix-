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
          onPrimary: Colors.white,
          secondary: VynixColors.lightAccentSecondary,
          onSecondary: Colors.white,
          error: VynixColors.coral,
          onError: Colors.white,
          surface: VynixColors.lightSurface,
          onSurface: VynixColors.lightPrimaryText,
          outline: VynixColors.lightBorder,
          surfaceContainerHighest: VynixColors.lightSurfaceElevated,
        );

    return _baseTheme(scheme).copyWith(
      scaffoldBackgroundColor: VynixColors.lightBackground,
      dividerColor: VynixColors.lightBorder,
      cardTheme: CardThemeData(
        color: VynixColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: VynixColors.lightBorder),
        ),
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
          outline: VynixColors.darkBorder,
          surfaceContainerHighest: VynixColors.darkSurfaceElevated,
        );

    return _baseTheme(scheme).copyWith(
      scaffoldBackgroundColor: VynixColors.darkBackground,
      dividerColor: VynixColors.darkBorder,
      cardTheme: CardThemeData(
        color: VynixColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: VynixColors.darkBorder),
        ),
      ),
    );
  }

  static ThemeData _baseTheme(ColorScheme colorScheme) {
    final baseTextTheme = GoogleFonts.interTextTheme();
    final themedText = baseTextTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: GoogleFonts.inter().fontFamily,
      textTheme: themedText.copyWith(
        displayLarge: themedText.displayLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -1.5,
        ),
        displayMedium: themedText.displayMedium?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        headlineLarge: themedText.headlineLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineMedium: themedText.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        titleLarge: themedText.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        titleMedium: themedText.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: themedText.bodyLarge?.copyWith(
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        bodyMedium: themedText.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        labelLarge: themedText.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
        labelMedium: themedText.labelMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
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
        scrolledUnderElevation: 0,
        centerTitle: false,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: colorScheme.outline),
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: 68,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.12),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 11,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
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
        inactiveTrackColor: colorScheme.onSurface.withValues(alpha: 0.12),
        overlayColor: colorScheme.primary.withValues(alpha: 0.12),
      ),
      chipTheme: ChipThemeData(
        selectedColor: colorScheme.primary.withValues(alpha: 0.14),
        backgroundColor: colorScheme.surface,
        side: BorderSide(color: colorScheme.outline),
        labelStyle: themedText.labelMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.brightness == Brightness.dark
            ? VynixColors.darkSurfaceElevated
            : VynixColors.lightBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: themedText.bodyMedium?.copyWith(
          color: colorScheme.brightness == Brightness.dark
              ? VynixColors.darkSecondaryText
              : VynixColors.lightSecondaryText,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outline,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
