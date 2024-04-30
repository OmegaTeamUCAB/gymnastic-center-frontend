import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      dividerTheme: const DividerThemeData(
        color: Color.fromRGBO(0, 0, 0, 0.09),
      ),
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F14A0),
          primary: const Color(0xFF4F14A0),
          secondary: const Color(0xFF8066FF),
          background: Colors.white,
          onBackground: Colors.white,
          onSurface: Colors.white, // content inside button
          outline: const Color(0xFFCDCDCD),
          onSecondaryContainer: const Color(0xFFCDCDCD),
          onPrimaryContainer: const Color(0xFF4F14A0),
          brightness: Brightness.light,
          onPrimary: const Color(0xFF2D2D3A)),
      textTheme: GoogleFonts.ptSansTextTheme().copyWith(
          titleLarge: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
              color: Color(0xFF2D2D3A))),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      dividerTheme: const DividerThemeData(color: Colors.white, space: 20),
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F14A0),
          primary: Colors.white,
          background: const Color(0xff2D2D3A),
          secondary: const Color(0xFF8066FF),
          onSurface: const Color(0xFF4F14A0),
          outline: Colors.white,
          onSecondaryContainer: const Color(0xFF8B8B93),
          onPrimaryContainer: Colors.white,
          onBackground: const Color(0xFF2D2D3A),
          brightness: Brightness.dark,
          onPrimary: Colors.white),
      textTheme: GoogleFonts.ptSansTextTheme().copyWith(
          bodyMedium: const TextStyle(color: Colors.white),
          titleLarge: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 36, color: Colors.white)),
    );
  }
}
