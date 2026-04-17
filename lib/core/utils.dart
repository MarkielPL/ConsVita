import 'global_imports.dart';

/// Klasa konfiguracji motywów
class ThemeUtils {
  /// Jasny motyw aplikacji
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme(), // Ustawienie czcionki Poppins
  );

  /// Ciemny motyw aplikacji
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}

/// Provider odpowiedzialny za przechowywanie i zmianę motywu
class ThemeProvider with ChangeNotifier {
  bool isDark;

  /// Konstruktor przyjmujący stan początkowy
  ThemeProvider(this.isDark);

  /// Zwraca aktualny motyw
  ThemeData get currentTheme =>
      isDark ? ThemeUtils.darkTheme : ThemeUtils.lightTheme;

  /// Przełącza tryb jasny/ciemny i zapisuje wybór w pamięci urządzenia
  void toggleTheme() async {
    isDark = !isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDarkMode", isDark); // Zapis do pamięci trwałej
    notifyListeners(); // Powiadomienie widżetów o zmianie
  }
}

/// Provider zarządzający aktualnym językiem aplikacji
class LocaleProvider with ChangeNotifier {
  Locale locale;

  /// Konstruktor przyjmujący bieżący język
  LocaleProvider(this.locale);

  /// Ustawia nowy język i zapisuje go w pamięci urządzenia
  void setLocale(Locale newLocale) async {
    locale = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("locale", newLocale.languageCode); // Zapis języka
    notifyListeners(); // Odświeżenie interfejsu
  }
}
