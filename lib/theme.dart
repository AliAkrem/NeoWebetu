import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

var appThemeDark = ThemeData(
    fontFamily: GoogleFonts.nunito().fontFamily,
    fontFamilyFallback: [
      ...?GoogleFonts.nunito().fontFamilyFallback,
      'NotoKufiArabic'
    ],
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      secondary: Color(0xFF4285F4),
      primary: Color(0xFF34A853),
      surface: Color(0xFF1F1F1F),
      error: Color(0xFFEA4335),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 1,
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF34A853),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: inputDecorationTheme);

var appThemeLight = ThemeData(
  fontFamily: GoogleFonts.nunito().fontFamily,
  fontFamilyFallback: [
    ...?GoogleFonts.nunito().fontFamilyFallback,
    'NotoKufiArabic'
  ],
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    secondary: Color(0xFF4285F4),
    primary: Color(0xFF34A853),
    surface: Colors.white,
    error: Color(0xFFEA4335),
    onSurface: Colors.black87,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: false,
    elevation: 1,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 22,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFF34A853),
    unselectedItemColor: Colors.black54,
  ),
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: inputDecorationTheme.copyWith(
    fillColor: Colors.grey[100],
    hintStyle: TextStyle(color: Colors.black54),
    labelStyle: TextStyle(color: Colors.black87),
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),
);
