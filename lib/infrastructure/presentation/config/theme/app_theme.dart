import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final seedColor = const Color(0xFF4F14A0);
  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          primary: const Color(0xFF4F14A0),
          secondary: const Color(0xFF8066FF),
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

  ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          primary: Colors.white,
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
