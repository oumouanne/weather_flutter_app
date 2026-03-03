import 'package:flutter/material.dart';
<<<<<<< HEAD
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

=======

class WeatherProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

>>>>>>> 1fa7db75dc559c594d9bf2a0be2a97d550e3886a
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
<<<<<<< HEAD

  void clearWeatherData() {
    weatherData.clear();
    notifyListeners();
  }

  void addWeatherData(WeatherModel data) {
    weatherData.add(data);
    notifyListeners();
  }
}
=======
}
>>>>>>> 1fa7db75dc559c594d9bf2a0be2a97d550e3886a
