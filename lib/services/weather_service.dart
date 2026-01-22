import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = '214623221d3ff6fdcceae9b83b81bbf6';
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> getWeatherByLocation(
      double lat, double lon) async {
    final url = "$_baseUrl?lat=$lat&lon=$lon&units=metric&appid=$_apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
