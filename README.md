# 📱 Flutter Weather & To-Do App

Nazwa aplikacji pochodzi od połączenia łacińskiego planować życie - consilium vitae = Consvita
# założenia początkowe
„Pierwsze kroki”: 
```
flutter pub upgrade --major-versions

flutter clean
flutter pub get
flutter run -d windows
```
Polecenia klawiszowe 

```
r Hot reload.
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).      
c Clear the screen
q Quit (terminate the application on the device).
```


### 🧠 Organizacja kodu
Wysoki stopień złożoności wymaga dobrej organizacji kodu:

```
lib/                                                      opis
│   app.dart
│   main.dart                                             # punkt startowy aplikacji
│   README.md                                             # opis projektu
│
├───core                                                  # ogólne konfiguracje, motywy
│   │   constants.dart     
│   │   global_imports.dart                               # zarządzanie importy
│   │   utils.dart
│   │
│   └───themes
├───lang                                                  # tłumaczenia
│       intl_en.arb
│       intl_pl.arb
│
├───models                                                # wspólne modele danych
│       settings_model.dart
│       todo_model.dart
│       weather_model.dart
│
├───screens
│   ├───calendar                                          # Zakładka 3: To-Do + Kalendarz
│   │   │   calendar_screen.dart
│   │   │
│   │   └───widgets
│   ├───home                                              # Zakładka 1: Główna
│   │   │   home_screen.dart                
│   │   │
│   │   └───widgets
│   ├───settings                                          # Zakładka 4: Ustawienia
│   │   │   settings_screen.dart                          # UI ustawień + logika
│   │   │
│   │   └───widgets
│   └───weather                                           # Zakładka 2: Pogoda
│       │   weather_screen.dart
│       │
│       └───widgets
├───services                                              # usługi globalne: API, lokalizacja, notyfikacje
│   ├───api
│   ├───location
│   └───storage
└───widgets                                               # globalne widgety wspólne
        custom_button.dart
```

## 🌐 Biblioteki globalne

| Zastosowanie               | Biblioteka                               | Źródło                                                                                                        |
| -------------------------- | ---------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Splash screen              | `flutter_native_splash`                  | [🔗](https://pub.dev/packages/flutter_native_splash)                                                          |
| Animacja ładowania         | `flutter_spinkit`                        | [🔗](https://pub.dev/packages/flutter_spinkit)                                                                |
| Czcionki                   | `google_fonts`                           | [🔗](https://pub.dev/packages/google_fonts)                                                                   |
| Zarządzanie stanem         | `flutter_bloc` / `provider` / `riverpod` | [🔗](https://medium.com/@punithsuppar7795/flutter-state-management-provider-vs-riverpod-vs-bloc-557938a3d54e) |
| Ustawienia/cache           | `shared_preferences`                     | [🔗](https://pub.dev/packages/shared_preferences)                                                             |
| Lokalizacje systemowe      | `flutter_localizations`                  | [🔗](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)                 | https://localizely.com/blog/flutter-localization-step-by-step/?tab=using-gen-l10n
| Lokalizacja językowa       | `intl`                                   | [🔗](https://pub.dev/packages/intl)                                                                           |
| Iniekcja zależności        | `get_it`                                 | [🔗](https://pub.dev/packages/get_it)                                                                         |
| Ikony SVG                  | `flutter_svg`                            | [🔗](https://pub.dev/packages/flutter_svg)                                                                    |
| Linki zewnętrzne           | `url_launcher`                           | [🔗](https://pub.dev/packages/url_launcher)                                                                   |
| Łączność z internetem      | `connectivity_plus`                      | [🔗](https://pub.dev/packages/connectivity_plus)                                                              |
| Mapa interaktywna          | `google_maps_flutter`                    | [🔗](https://pub.dev/packages/google_maps_flutter)                                                            |
| Geolokalizacja użytkownika | `geolocator`                             | [🔗](https://pub.dev/packages/geolocator)                                                                     |
| Formularze i walidacja     | `flutter_form_builder`                   | [🔗](https://pub.dev/packages/flutter_form_builder)                                                           |
| Ścieżki plików             | `path_provider`                          | [🔗](https://pub.dev/packages/path_provider)                                                                  |


## 🧩 Zakładka 1: Strona główna (Skróty)

### 📌 Funkcje:
- Widżety skrótów do zakładek
- Podsumowanie dzisiejszych danych (pogoda, wydarzenia)

### 🛠️ Todo:
- Implementacja `AnimatedContainer`
- Onboarding z wykorzystaniem `PageView`
- Integracja `BottomNavigationBar` z `NestedScrollView`
- Dodanie animacji `Hero`, niestandardowe przejścia, `haptic feedback`

### 📚 Biblioteki:

| Zastosowanie                       | Biblioteka                               | Źródło                                                    |
|------------------------------------|------------------------------------------|-----------------------------------------------------------|
| Animowane ikony                    | `flutter_animated_icons`                 | [🔗](https://pub.dev/packages/flutter_animated_icons)     |
| Kafelkowy układ skrótów            | `flutter_staggered_grid_view`            | [🔗](https://pub.dev/packages/flutter_staggered_grid_view)|
| Animacje przejść                   | `animations`                             | [🔗](https://pub.dev/packages/animations)                 |
| Można też wykorzystanić            | `flutter_spinkit`, `google_fonts`,       |
|                                    | `provider`                               |



## 🌦️ Zakładka 2: Pogoda z mapą

### 📌 Funkcje:
- Interaktywna mapa pogodowa
- Szczegóły pogodowe: wykresy, opisy
- Obsługa wielu lokalizacji
- Obsługa offline (cache)

### 🛠️ Todo:
- Wybór jednostek (°C/°F, km/h/mph)
- Geolokalizacja + zapamiętywanie lokalizacji
- Pull-to-refresh / Skeleton loader

### 📚 Biblioteki:

| Zastosowanie                       | Biblioteka                               | Źródło                                                                   |
|------------------------------------|------------------------------------------|--------------------------------------------------------------------------|
| Połączenie z API                   | `http`/ `dio`                            | [🔗](https://medium.com/@vikranthsalian/flutter-dio-vs-http-1dc1d4f95fda)|
| Ikony pogodowe i animacje          | `lottie`                                 | [🔗](https://pub.dev/packages/lottie)                                    |
| Wizualizacja danych pogodowych     | `fl_chart`                               | [🔗](https://pub.dev/packages/fl_chart)                                  |
| Można też wykorzystanić            | `google_maps_flutter`, `geolocator`,     |
|                                    | `weather_icons`                          |

wykorzystane ikony pogodowe **weather icons** [🔗](https://github.com/basmilius/weather-icons/tree/dev/production/fill/png/1024)


## 🗓️ Zakładka 3: To-Do + Kalendarz

### 📌 Funkcje:
- Lista zadań (dodaj, edytuj, usuń)
- Walidacja formularzy
- Notyfikacje push
- Zadania z lokalizacją na mapie

### 🛠️ Todo:
- Kategorie, tagi, sortowanie, integracja z Google Calendar
- MVP: lista zadań + lokalizacja

### 📚 Biblioteki:

| Zastosowanie                       | Biblioteka                               | Źródło                                                    |
|------------------------------------|------------------------------------------|-----------------------------------------------------------|
| Widok kalendarza                   | `flutter_enhanced_timetable`             | [🔗](https://pub.dev/packages/flutter_enhanced_timetable) |
| Baza danych offline                | `sqflite`                                | [🔗](https://pub.dev/packages/sqflite)                    |
| Przypomnienia lokalne              | `flutter_local_notifications`            | [🔗](https://pub.dev/packages/flutter_local_notifications)|
| Można też wykorzystanić            | `flutter_form_builder`,                  |
|                                    | `google_maps_flutter`, `geolocator`,     |
|                                    | `path_provider`, `table_calendar`        |


## ⚙️ Zakładka 4: Ustawienia

### 📌 Funkcje:
- Motyw: jasny/ciemny/systemowy
- Zmiana języka i podgląd zmian na żywo
- Wybór źródła API pogodowego
- Ustawienia prywatności i synchronizacji

### 🛠️ Todo:
- Dodanie opcji resetowania ustawień do domyślnych
- Integracja z kontem użytkownika (np. Google Sign-In)

### 📚 Biblioteki:

| Zastosowanie                       | Biblioteka                               |Żródło                                         |
|------------------------------------|------------------------------------------|-----------------------------------------------|
| UI dla ustawień                    | `settings_ui`                            | [🔗](https://pub.dev/packages/settings_ui)    |
| Dynamiczny motyw (ciemny/jasny)    | `adaptive_theme`                         | [🔗](https://pub.dev/packages/adaptive_theme) |
| Można też wykorzystanić            | `intl`, `provider`, `shared_preferences` |


## 🧩 Dodatkowe zalecenia
- Użycie `get_it` do rozdzielenia zależności (np. repozytorium danych)
- Testowanie trybu offline: mocki, lokalna pamięć cache
- Try Catch + `ScaffoldMessenger` do komunikacji błędów
- Zapewnienie responsywności dla ekranów tabletów (MediaQuery / LayoutBuilder)

---
