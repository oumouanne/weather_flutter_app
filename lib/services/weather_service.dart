import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
///la partie gerée par khady dieng

class WeatherService {
  final String apiKey = '85f516b7d9cf2178525b074d497549f6';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  final List<String> cities = [
    "Dakar",
    "Paris",
    "Dubai",
    "New York",
    "Tokyo"
  ];

  Future<WeatherModel> fetchWeather(String city) async {
    final url =
    Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        throw Exception("Impossible de récupérer les données");
      }
    } catch (e) {
      throw Exception("Impossible de récupérer les données");
    }
  }
}