import 'package:consvita/core/global_imports.dart';
import 'package:consvita/models/weather_model.dart';
import 'package:consvita/services/api/weather_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather_icons/weather_icons.dart';

/// Dane pogodowe z mapą i lokalizacją
class WeatherBody extends StatefulWidget {
  const WeatherBody({super.key});

  @override
  State<WeatherBody> createState() => _WeatherBodyState();
}
// klasa _WeatherBodyState jest odpowiedzialna za pobieranie i wyświetlanie danych pogodowych
class _WeatherBodyState extends State<WeatherBody> {
  final _weatherService = WeatherService('3f3d60bab6c43fceb12385542497a3cb');
  WeatherData? _weatherData;

  Future<void> _fetchWeather() async {
    try {
      final weatherData = await _weatherService.getWeather('Szczecin');
      setState(() => _weatherData = weatherData);
    } catch (e) {
      debugPrint('${'error_weather'.tr()}: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return WeatherIcons.day_sunny;
      case 'clouds':
        return WeatherIcons.cloudy;
      case 'rain':
        return WeatherIcons.rain;
      case 'thunderstorm':
        return WeatherIcons.thunderstorm;
      case 'drizzle':
        return WeatherIcons.showers;
      case 'snow':
        return WeatherIcons.snow;
      case 'mist':
      case 'fog':
        return WeatherIcons.fog;
      default:
        return WeatherIcons.na;
    }
  }
// metoda, wyświetla dane pogodowe i mapę
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_weatherData != null)
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    _weatherData!.cityName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  BoxedIcon(
                    getWeatherIcon(_weatherData!.condition),
                    size: 64,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 8),
                  Text('${'temperature'.tr()}: ${_weatherData!.temperature.round()} °C'),
                  Text('${'humidity'.tr()}: ${_weatherData!.humidity.round()} %'),
                ],
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const SpinKitCircle(size: 80, color: Color.fromARGB(255, 190, 30, 97)),
                const SizedBox(height: 16),
                Text("weather_loading".tr()),
              ],
            ),
          ),
        // Mapa z lokalizacją
        Expanded(
          child: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(53.4285, 14.5528),
              initialZoom: 11,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              if (_weatherData != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 50,
                      height: 50,
                      point: LatLng(53.4285, 14.5528),
                      child: const Icon(Icons.location_pin, size: 40, color: Colors.red),
                    ),
                  ],
                ),
            ],
          ),
        )
      ],
    );
  }
}
