import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class ApiWeatherScreen extends StatelessWidget {
  // ⚡ Ajouter ce paramètre final
  final Map<String, WeatherModel?> weatherData;

  // ⚡ Ajouter ce paramètre au constructeur
  const ApiWeatherScreen({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Météo détaillée"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: weatherData.entries.map((entry) {
          final city = entry.key;
          final data = entry.value;

          if (data == null) {
            return ListTile(
              title: Text(city),
              subtitle: const Text("Données non disponibles"),
            );
          }

          return Card(
            child: ListTile(
              title: Text("${data.city} : ${data.temperature.toStringAsFixed(1)}°C"),
              subtitle: Text("Condition: ${data.condition}, Humidité: ${data.humidity}%"),
            ),
          );
        }).toList(),
      ),
    );
  }
}