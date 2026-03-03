import 'dart:async';
import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import 'package:provider/provider.dart';
import '../services/weather_provider.dart';
import 'api_weather_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _service = WeatherService();
<<<<<<< HEAD
  final List<String> _cities = ['Dakar', 'Paris', 'Dubai', 'New York', 'Tokyo'];
=======
  final List<String> _cities = ['Dakar', 'Paris', 'London', 'New York', 'Tokyo'];
>>>>>>> 1fa7db75dc559c594d9bf2a0be2a97d550e3886a

  Map<String, WeatherModel?> _weatherData = {};
  int _currentIndex = 0;
  Timer? _messageTimer;

  final List<String> _messages = [
    "📡 Nous téléchargeons les données…",
    "🌍 Localisation en cours…",
    "☁️ Analyse des nuages…",
    "🌤️ Presque terminé…",
    "✅ Chargement terminé !",
  ];

  int _messageIndex = 0;
  String _currentMessage = "📡 Nous téléchargeons les données…";

  @override
  void initState() {
    super.initState();
    _startMessages();
    _startFetching();
  }

  // Messages dynamiques
  void _startMessages() {
<<<<<<< HEAD
    _messageTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
=======
    _messageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
>>>>>>> 1fa7db75dc559c594d9bf2a0be2a97d550e3886a
      if (!mounted) return;

      setState(() {
        if (_currentIndex < _cities.length) {
          _currentMessage =
          _messages[_messageIndex % (_messages.length - 1)];
        } else {
          _currentMessage = _messages.last;
        }
        _messageIndex++;
      });
    });
  }

  // Appels API progressifs propres
  Future<void> _startFetching() async {
    for (int i = 0; i < _cities.length; i++) {
      String city = _cities[i];

      try {
        final weather = await _service.fetchWeather(city);

        if (!mounted) return;

        setState(() {
          _weatherData[city] = weather;
          _currentIndex++;
        });

        // Pause pour voir la progression
        await Future.delayed(const Duration(seconds: 2));
      } catch (e) {
        if (!mounted) return;

        setState(() {
          _currentIndex++;
        });
      }
    }

    // Attendre un peu avant navigation
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ApiWeatherScreen(weatherData: _weatherData),
      ),
    );
  }

  @override
  void dispose() {
    _messageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<WeatherProvider>(context).isDarkMode;

    String currentCity =
    _currentIndex > 0 && _currentIndex <= _cities.length
        ? _cities[_currentIndex - 1]
        : _cities.first;

    double temp = _weatherData[currentCity]?.temperature ?? 0;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Météo des 5 villes'),
        centerTitle: true,
        backgroundColor: isDark ? Colors.grey[900] : Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Message dynamique
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                _currentMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),

            // Jauge circulaire
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: _currentIndex / _cities.length,
                    strokeWidth: 10,
                    color: Colors.blue,
                    backgroundColor: Colors.grey[300],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${temp.toStringAsFixed(1)}°C',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      currentCity,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Liste des villes
            Column(
              children: _cities.map((city) {
                bool fetched = _weatherData[city] != null;

                return ListTile(
                  leading: Icon(
                    fetched
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: fetched ? Colors.green : Colors.grey,
                  ),
                  title: Text(
                    city,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: fetched
                      ? Text(
                    '${_weatherData[city]?.temperature?.toStringAsFixed(1)}°C',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  )
                      : null,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 1fa7db75dc559c594d9bf2a0be2a97d550e3886a
