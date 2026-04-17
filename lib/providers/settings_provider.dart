import 'package:consvita/core/global_imports.dart';
import 'package:consvita/models/app_theme_mode.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:consvita/models/settings_model.dart';

/// Kontroler ustawień oparty o StateNotifier
class SettingsContrtoller extends StateNotifier<SettingsModel> {
  SettingsContrtoller()
      : super(SettingsModel(
          themeMode: AppThemeMode.system,
          languageCode: 'pl',
          useCustomTheme: false,
        ));

  bool settingsRead = false;

  Future<void> loadSettings(BuildContext context) async {
    if (!settingsRead) {
      // print("Odczytuje ustawienia");

      final prefs = await SharedPreferences.getInstance();

      final languageCode = prefs.getString('languageCode') ?? 'pl';
      setLanguage(languageCode, context);

      final useCustomTheme = prefs.getBool('useCustomTheme') ?? false;
      toggleCustomTheme(useCustomTheme);

      final themeCode = prefs.getString('themeMode') ?? '';
      setThemeMode(AppThemeMode.fromCode(themeCode));

      settingsRead = true; // Wylacza odczyt danych po pierwszym odczytaniu
    }
  }

  /// Zmienia tryb aplikacji
  void toggleCustomTheme(bool value) {
    state = state.copyWith(useCustomTheme: value);
  }

  /// Zmienia motyw motywu
  void setThemeMode(AppThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  /// Zmienia język aplikacji
  void setLanguage(String code, BuildContext context) {
    state = state.copyWith(languageCode: code);
    context.setLocale(getLocaleByCode(code)); // integrator easy_localization
  }

  /// Lista dostępnych motywów
  static List<DropdownMenuItem<AppThemeMode>> getThemeItems() =>
      AppThemeMode.values
          .map((mode) => DropdownMenuItem(
                value: mode,
                child: Text(mode.label),
              ))
          .toList();

  /// Lista dostępnych języków
  static List<DropdownMenuItem<String>> getLanguageItems() =>
      ['pl', 'en']
          .map((code) => DropdownMenuItem(
                value: code,
                child: Text(code == 'pl' ? 'Polski' : 'English'),
              ))
          .toList();
}

/// Provider zarządzający ustawieniami użytkownika
final settingsProvider = StateNotifierProvider<SettingsContrtoller, SettingsModel>((ref) {
  return SettingsContrtoller();
});

