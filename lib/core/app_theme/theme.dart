import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const _lightSeedColour = Color(0xFF01AFFF);
  static const _darkSeedColour = Color(0xFF00246B);

  static final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    seedColor: _lightSeedColour,
    brightness: Brightness.light,
  );

  static final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    seedColor: _darkSeedColour,
    brightness: Brightness.dark,
  );

  static ThemeData _baseTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Switzer',

      scaffoldBackgroundColor: colorScheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 26,
          fontWeight: FontWeight.w600,
          fontFamily: 'Switzer',
        ),
      ),

      drawerTheme: DrawerThemeData(backgroundColor: colorScheme.surface),

      inputDecorationTheme: InputDecorationTheme(
        fillColor: colorScheme.surfaceContainerHighest,
        filled: true,
        errorStyle: TextStyle(color: colorScheme.error, fontSize: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        circularTrackColor: colorScheme.onSecondary,
      ),

      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(colorScheme.surfaceContainer),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0.0),
        constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            color: colorScheme.onSurface,
            fontSize: 16,
            fontFamily: 'Switzer',
          ),
        ),
        hintStyle: WidgetStateProperty.all(
          TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: 16,
            fontFamily: 'Switzer',
          ),
        ),
      ),
    );
  }

  static ThemeData get lightTheme => _baseTheme(_lightColorScheme);
  static ThemeData get darkTheme => _baseTheme(_darkColorScheme);
}
