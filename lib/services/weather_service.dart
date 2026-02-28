import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = 'VOTRE_API_KEY'; // Insérer clé OpenWeatherMap
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel?> fetchWeather(String city) async {
    final url = Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        print("Erreur API : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Impossible de récupérer les données : $e");
      return null;
    }
  }
}