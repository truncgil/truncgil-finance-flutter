import 'package:flutter/material.dart';

class AppTheme {
  // Logo renkleri
  static const Color truncgilGreen = Color(0xFF00FF66);
  static const Color truncgilWhite = Colors.white;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: truncgilGreen,
      secondary: truncgilGreen.withOpacity(0.8),
      tertiary: truncgilGreen.withOpacity(0.6),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      error: Colors.red,
      surface: Colors.grey.shade100,
      onSurface: Colors.black87,
      background: Colors.white,
      onBackground: Colors.black87,
      surfaceVariant: Colors.grey.shade200,
      onSurfaceVariant: Colors.black87,
      outline: Colors.grey.shade300,
    ),
    dividerColor: Colors.grey.shade200,
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    tabBarTheme: TabBarTheme(
      dividerColor: Colors.transparent,
      indicatorColor: truncgilGreen,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2, color: truncgilGreen),
        insets: const EdgeInsets.symmetric(horizontal: 16),
      ),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      labelColor: truncgilGreen,
      unselectedLabelColor: Colors.grey,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: truncgilGreen,
      secondary: truncgilGreen.withOpacity(0.8),
      tertiary: truncgilGreen.withOpacity(0.6),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      error: Colors.red,
      surface: Colors.grey.shade900,
      onSurface: Colors.white,
      background: Colors.black,
      onBackground: Colors.white,
      surfaceVariant: Colors.grey.shade800,
      onSurfaceVariant: Colors.white70,
      outline: Colors.grey.shade700,
    ),
    dividerColor: Colors.grey.shade800,
    cardTheme: CardTheme(
      color: Colors.grey.shade900,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    tabBarTheme: TabBarTheme(
      dividerColor: Colors.transparent,
      indicatorColor: truncgilGreen,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2, color: truncgilGreen),
        insets: const EdgeInsets.symmetric(horizontal: 16),
      ),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      labelColor: truncgilGreen,
      unselectedLabelColor: Colors.grey,
    ),
  );
}
