import 'package:easy_localization/easy_localization.dart';

/// Enum trybu motywu aplikacji
enum AppThemeMode {
  system,
  light,
  dark;

  /// Nazwa do wyświetlenia
  String get label => switch (this) {
        AppThemeMode.system => 'system'.tr(),
        AppThemeMode.light => 'light'.tr(),
        AppThemeMode.dark => 'dark'.tr(),
      };

  /// Przechowywanie w SharedPreferences
  String get code => toString().split('.').last;

  /// Parsowanie kodu na enum
  static AppThemeMode fromCode(String code) {
    return AppThemeMode.values.firstWhere(
      (e) => e.code == code,
      orElse: () => AppThemeMode.system,
    );
  }
}

