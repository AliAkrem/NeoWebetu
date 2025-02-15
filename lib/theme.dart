import 'package:flutter/material.dart';

final inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: Color(0xFF2D2D2D),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Color(0xFF4285F4), width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Color(0xFFEA4335), width: 2),
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
);

var appTheme = ThemeData(
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF4285F4),
      secondary: Color(0xFF34A853),
      surface: Color(0xFF1F1F1F),
      error: Color(0xFFEA4335),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Color(0xFF1F1F1F),
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: inputDecorationTheme);
