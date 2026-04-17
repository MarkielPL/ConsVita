import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Styl cyber – neonowy, fioletowo-niebieski
final cyberTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0A0F2C),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF3F0071),
    foregroundColor: Colors.white,
  ),
  primaryColor: const Color(0xFF8A2BE2),
  colorScheme: const ColorScheme.dark().copyWith(
    secondary: Colors.cyanAccent,
  ),
  cardColor: const Color(0xFF1A1A2E),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.indigoAccent,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xFF1E1E2C), // ciemny fiolet
    elevation: 16, // mocniejszy cień
    shadowColor: const Color(0xFF00FFFF).withOpacity(0.7), // neonowy niebieski cień
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(
        color: const Color(0xFF00FFFF).withOpacity(0.8), // neonowy niebieski obwód
        width: 3.0, // grubszy obwód
      ),
    ),
  ),
  textTheme: GoogleFonts.orbitronTextTheme(
    ThemeData.dark().textTheme,
  ),
  
);
