import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors
  static const Color primary = Color(0xFF3B66F5);
  static const Color primaryDark = Color(0xFF2347C5);
  static const Color primaryLight = Color(0xFFEEF3FF);

  // Neutral Colors
  static const Color background = Color(0xFFF8FAFD);
  static const Color surface = Colors.white;
  static const Color textDark = Color(0xFF192238);
  static const Color textMedium = Color(0xFF475569);
  static const Color textGrey = Color(0xFF94A3B8);
  static const Color border = Color(0xFFE2E8F0);

  // Status / Priority Colors
  static const Color priorityHighText = Color(0xFFDC2626);
  static const Color priorityHighBg = Color(0xFFFFEDEC);
  static const Color priorityMediumText = Color(0xFFD97706);
  static const Color priorityMediumBg = Color(0xFFFEF3C7);
  static const Color priorityLowText = Color(0xFF059669);
  static const Color priorityLowBg = Color(0xFFECFDF5);

  // Note Card Pastel Palette
  static const Color noteYellow = Color(0xFFFFF6D6);
  static const Color noteMint = Color(0xFFDDF7EE);
  static const Color notePurple = Color(0xFFEAE6FC);
  static const Color notePink = Color(0xFFFFE5EB);
  static const Color noteBlue = Color(0xFFE2EFFF);

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          primary: primary,
          surface: surface,
          surfaceTint: Colors.transparent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textDark,
          ),
          iconTheme: IconThemeData(color: textDark),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            elevation: 2,
            shadowColor: primary.withValues(alpha: 0.35),
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: textDark,
            minimumSize: const Size(double.infinity, 52),
            side: const BorderSide(color: border, width: 1.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          hintStyle: const TextStyle(
            color: textGrey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          prefixIconColor: textGrey,
          suffixIconColor: textGrey,
          border: _border(border),
          enabledBorder: _border(border),
          focusedBorder: _border(primary, width: 1.8),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: border, width: 1),
          ),
        ),
      );

  static OutlineInputBorder _border(Color color, {double width = 1.0}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: width),
      );
}
