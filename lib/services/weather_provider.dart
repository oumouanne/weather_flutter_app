import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  // --- Thème ---
  bool _isDarkMode = false;

  // --- Données météo ---
  List<WeatherModel> weatherData = [];

  // --- GETTERS ---
  bool get isDarkMode => _isDarkMode;

  // --- Méthodes ---
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void clearWeatherData() {
    weatherData.clear();
    notifyListeners();
  }

  void addWeatherData(WeatherModel data) {
    weatherData.add(data);
    notifyListeners();
  }
}
