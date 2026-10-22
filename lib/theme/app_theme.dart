import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF2F6BFF);
  static const Color background = Color(0xFFF5F8FF);
  static const Color textDark = Color(0xFF0F1B4C);
  static const Color textGrey = Color(0xFF6B7280);

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: background,
    colorScheme: ColorScheme.fromSeed(seedColor: primary),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        // minimumSize: Size(double.infinity, 50)
        // shape: RoundedRectangleBorder radius 12
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      // border, enabledBorder, focusedBorder
    ),
  );
}
