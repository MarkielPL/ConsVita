import 'dart:convert';

import 'package:consvita/models/weather_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String _apiKey;
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  WeatherService(this._apiKey);

  Future<WeatherData> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey&units=metric'));
    
    if (response.statusCode == 200) { // OK
      return WeatherData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('error_weather'.tr());
    }
  }

}

