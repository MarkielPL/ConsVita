import 'package:easy_localization/easy_localization.dart';
import 'core/global_imports.dart';
import 'app.dart';


/// Punkt wejściowy aplikacji
void main() async {
  // Inicjalizacja Fluttera
  WidgetsFlutterBinding.ensureInitialized();

  // Inicjalizacja EasyLocalization (tłumaczenia)
  await EasyLocalization.ensureInitialized();

  runApp(
    // Konfiguracja lokalizacji
    EasyLocalization(
      supportedLocales: const [Locale('pl'), Locale('en')],
      path: 'lib/l10n', // Pliki tłumaczeń JSON
      fallbackLocale: const Locale('en'), // Domyślny język

      // Riverpod obsługuje całą aplikację
      child: ProviderScope(
        child: const ConsvitaApp(),
      ),
    ),
  );
}
