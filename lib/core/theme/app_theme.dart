import 'package:drip_society/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightOnPrimary,
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.lightOnSecondary,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightText,
      onSurfaceVariant: AppColors.lightSubtitle,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
      outline: AppColors.lightBorder,
      outlineVariant: AppColors.lightBorder,
      error: AppColors.lightError,
      onError: AppColors.lightOnError,
      shadow: AppColors.shadow,
    ),

    dividerColor: AppColors.lightBorder,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.lightText,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: AppColors.lightOnPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: AppColors.lightText),
      bodyMedium: TextStyle(color: AppColors.lightSubtitle),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkOnPrimary,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkOnSecondary,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkText,
      onSurfaceVariant: AppColors.darkSubtitle,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      outline: AppColors.darkBorder,
      outlineVariant: AppColors.darkBorder,
      error: AppColors.darkError,
      onError: AppColors.darkOnError,
      shadow: AppColors.shadow,
    ),

    dividerColor: AppColors.darkBorder,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.darkText,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkOnPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.darkText,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: AppColors.darkText,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: AppColors.darkText),
      bodyMedium: TextStyle(color: AppColors.darkSubtitle),
    ),
  );
}
