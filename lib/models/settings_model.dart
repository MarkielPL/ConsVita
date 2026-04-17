import 'package:consvita/core/global_imports.dart';
import 'app_theme_mode.dart';

Locale getLocaleByCode(String code) {
  switch (code) {
    case 'pl':
      return Locale('pl');
    case 'en':
      return Locale('en');
    default:
      return Locale('pl');
  }
}

/// Klucz do przechowywania ustawień w SharedPreferences
/// Model ustawień użytkownika
class SettingsModel {
  final AppThemeMode themeMode;
  final String languageCode;
  final bool useCustomTheme; // przełącznik niestandardowego motywu

  const SettingsModel({
    required this.themeMode,
    required this.languageCode,
    required this.useCustomTheme,
  });

  /// Tworzy nową kopię modelu z nadpisanymi wartościami
  SettingsModel copyWith({
    AppThemeMode? themeMode,
    String? languageCode,
    bool? useCustomTheme,
  }) {
    return SettingsModel(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      useCustomTheme: useCustomTheme ?? this.useCustomTheme,
    );
  }

  Future<void> saveSettings() async {
    // print("Zapisuje ustawienia");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', themeMode.code);
    await prefs.setString('languageCode', languageCode);
    await prefs.setBool('useCustomTheme', useCustomTheme);
  }
}
