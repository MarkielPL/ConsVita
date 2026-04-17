import 'package:consvita/providers/settings_provider.dart';
import 'package:consvita/screens/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/global_imports.dart';
import 'package:consvita/models/settings_model.dart';

import 'screens/home/home_screen.dart';
import 'screens/weather/weather_screen.dart';
import 'screens/calendar/calendar_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'package:consvita/core/theme.dart';

/// Wybiera odpowiedni ekran
class ScreenSelector extends ConsumerWidget {
  const ScreenSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);

    // Lista dostępnych ekranów
    const List<Widget> screens = [
      HomeScreen(),
      WeatherScreen(),
      CalendarScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      // Przełączanie ekranów z animacją
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: screens[currentIndex],
      ),

      // Dolny pasek nawigacji
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) =>
            ref.read(navigationProvider.notifier).setIndex(index),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 13,
        unselectedFontSize: 11,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.cloud),
            label: 'weather'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today),
            label: 'calendar'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'settings'.tr(),
          ),
        ],
      ),
    );
  }
}

/// Główna klasa aplikacji
class ConsvitaApp extends ConsumerWidget {
  const ConsvitaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Odczyt ustawień (język, motyw)
    final settings = ref.watch(settingsProvider);
    final settingsController = ref.read(settingsProvider.notifier);
    settingsController.loadSettings(context);

    // Pobranie aktualnego motywu
    final theme = ref.watch(themeDataProvider);
    context.setLocale(getLocaleByCode(settings.languageCode));

    return MaterialApp(
      title: 'appTitle'.tr(), // Tytuł aplikacji z tłumaczeń
      debugShowCheckedModeBanner: false,

      // Lokalizacja
      locale: getLocaleByCode(settings.languageCode),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      // Motyw aplikacji
      theme: theme,

      // Ekran startowy aplikacji
      home: SplashScreen(),
    );
  }
}
