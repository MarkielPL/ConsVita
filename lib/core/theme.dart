import 'package:consvita/core/global_imports.dart';
import 'package:consvita/core/themes/cyberTheme.dart';
import 'package:consvita/models/app_theme_mode.dart';
import 'package:consvita/providers/settings_provider.dart';
import 'package:flutter/scheduler.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
  scaffoldBackgroundColor: const Color(0xFFFDF6EC),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFAB40),
    foregroundColor: Colors.black,
  ),
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    bodyLarge: const TextStyle(color: Colors.black),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xFFFFF3E0),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1F1F1F),
    foregroundColor: Colors.white,
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
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
);


// Provider zwracający aktualny ThemeData (light/dark lub niestandardowy)
final themeDataProvider = Provider<ThemeData>((ref) {
  final settings = ref.watch(settingsProvider);
  if (settings.useCustomTheme) return cyberTheme;

  switch (settings.themeMode) {
    case AppThemeMode.light:
      return lightTheme;
    case AppThemeMode.dark:
      return darkTheme;
    case AppThemeMode.system:
    default:
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark ? darkTheme : lightTheme;
  }
});

final batterySaverProvider = StateProvider<bool>((ref) => false);
final optionABProvider = StateProvider<bool>((ref) => false);