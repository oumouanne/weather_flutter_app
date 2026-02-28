import 'dart:async';
import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class AutoUpdateWeather extends StatefulWidget {
  const AutoUpdateWeather({super.key});

  @override
  State<AutoUpdateWeather> createState() => _AutoUpdateWeatherState();
}

class _AutoUpdateWeatherState extends State<AutoUpdateWeather> {
  final List<String> cities = ['Dakar', 'Paris', 'London', 'New York', 'Tokyo'];
  final WeatherService _service = WeatherService();
  Map<String, WeatherModel?> weatherData = {};
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _fetchAllWeather();

    // Recharger toutes les 10 secondes
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _fetchAllWeather();
    });
  }

  Future<void> _fetchAllWeather() async {
    for (var city in cities) {
      final result = await _service.fetchWeather(city);
      if (result != null) {
        setState(() {
          weatherData[city] = result;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Impossible de récupérer les données pour $city')),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return weatherData.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];
        final weather = weatherData[city];

        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: weather == null
                ? Column(
              children: [
                Text(city, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _fetchAllWeather(),
                  child: const Text("Réessayer"),
                ),
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(weather.city,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text('Température: ${weather.temperature} °C'),
                Text('Condition: ${weather.condition}'),
                Text('Humidité: ${weather.humidity}%'),
              ],
            ),
          ),
        );
      },
    );
  }
}