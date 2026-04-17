/// Model danych pogodowych
class WeatherData {
  /// Nazwa miasta
  final String cityName;

  /// Temperatura w stopniach Celsjusza
  final double temperature;

  /// Stan pogody
  final String condition;

  /// Wilgotność powietrza w %
  final int humidity;

  /// Kod ikony pogodowej
  final String icon;

  /// Konstruktor klasy `WeatherData`
  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.condition,
    required this.icon,
  });

  /// Fabryczna metoda tworząca obiekt `WeatherData` z danych JSON
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'],                          // Nazwa miasta
      temperature: json['main']['temp'].toDouble(),    // Temperatura
      humidity: json['main']['humidity'].toInt(),      // Wilgotność
      condition: json['weather'][0]['main'],           // Warunki pogodowe
      icon: json['weather'][0]['icon'],                // Kod ikony pogodowej
    );
  }
}
