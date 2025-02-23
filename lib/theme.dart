import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: const Color(0xFF2D2D2D),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  
    borderSide: const BorderSide(color: Color(0xFF34A853),width: 1),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Color(0xFFEA4335), width: 2),
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
);

var appThemeDark = ThemeData(
    fontFamily: GoogleFonts.nunitoSans().fontFamily,
    fontFamilyFallback: [...?GoogleFonts.notoKufiArabic().fontFamilyFallback],
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      secondary: Color(0xFF4285F4),
      primary: Color(0xFF34A853),
      surface: Color(0xFF1F1F1F),
      error: Color(0xFFEA4335),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color.fromARGB(26, 52, 168, 83),
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF34A853),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: inputDecorationTheme);

var appThemeLight = ThemeData(
  fontFamily: GoogleFonts.nunitoSans().fontFamily,
  fontFamilyFallback: [...?GoogleFonts.notoKufiArabic().fontFamilyFallback],
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    secondary: Color(0xFF4285F4),
    primary: Color(0xFF34A853),
    surface: Colors.white,
    error: Color(0xFFEA4335),
    onSurface: Colors.black87,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(26, 52, 168, 83),
    titleTextStyle: TextStyle(
      fontSize: 22,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFF34A853),
    unselectedItemColor: Colors.black54,
  ),
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: inputDecorationTheme.copyWith(
    fillColor: Colors.grey[100],
    hintStyle: const TextStyle(color: Colors.black54),
    labelStyle: const TextStyle(color: Colors.black87),
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),
);
