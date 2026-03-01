import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import 'loading_screen.dart';
//la page ou il va afficher ce que khady a fait les api leur meteos ect-- des villes
class ResultScreen extends StatelessWidget {
  final List<WeatherModel> weatherData;

  const ResultScreen({
    super.key,
    required this.weatherData,
  });

  // Icône météo simplifiée selon condition
  IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.beach_access;
      case 'clear':
        return Icons.wb_sunny;
      case 'snow':
        return Icons.ac_unit;
      case 'thunderstorm':
        return Icons.flash_on;
      default:
        return Icons.wb_cloudy;
    }
  }

  Color getCardColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'clouds':
        return Colors.blueGrey.shade700;
      case 'rain':
        return Colors.blue.shade700;
      case 'clear':
        return Colors.orange.shade600;
      case 'snow':
        return Colors.cyan.shade400;
      case 'thunderstorm':
        return Colors.deepPurple.shade700;
      default:
        return Colors.grey.shade800;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Météo des villes"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: weatherData.length,
            itemBuilder: (context, index) {
              final cityWeather = weatherData[index];
              return Card(
                color: getCardColor(cityWeather.condition),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  leading: Icon(
                    getWeatherIcon(cityWeather.condition),
                    color: Colors.yellowAccent,
                    size: 40,
                  ),
                  title: Text(
                    cityWeather.city,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        "Température: ${cityWeather.temperature}°C",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        "Humidité: ${cityWeather.humidity}%",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        "Condition: ${cityWeather.condition}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}