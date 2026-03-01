import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'result_screen.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
//la  deuxiem page pour faire les telechargement des 5 villes loading_screen geré par Oumou Anne

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {

  double progress = 0.0;
  int completedCities = 0;

  List<String> messages = [
    "Nous téléchargeons les données...",
    "C’est presque fini...",
    "Plus que quelques secondes...",
  ];

  int messageIndex = 0;

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    // Animation de pulsation du pourcentage
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    startLoading();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void startLoading() async {
    final weatherService = WeatherService();
    List<WeatherModel> weatherList = [];

    for (String city in weatherService.cities) {
      try {
        WeatherModel weather = await weatherService.fetchWeather(city);
        weatherList.add(weather);

        setState(() {
          completedCities++;
          progress = completedCities / weatherService.cities.length;
          messageIndex = (messageIndex + 1) % messages.length;
        });

      } catch (e) {
        print("Erreur pour $city : $e");
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(weatherData: weatherList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherService = WeatherService();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Message
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  messages[messageIndex],
                  key: ValueKey(messageIndex),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Pourcentage circulaire avec pulsation
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  double scale = 1 + (_pulseController.value * 0.05);
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: CircularPercentIndicator(
                  radius: 140,
                  lineWidth: 16,
                  percent: progress,
                  animation: true,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${(progress * 100).toInt()}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "$completedCities / ${weatherService.cities.length} villes",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.amberAccent,
                  backgroundColor: Colors.white24,
                ),
              ),

              const SizedBox(height: 40),

              // Liste des villes avec animation fade
              Column(
                children: List.generate(weatherService.cities.length, (index) {
                  bool isDone = index < completedCities;
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isDone ? 1 : 0.6,
                    child: ListTile(
                      leading: Icon(
                        isDone ? Icons.cloud_done : Icons.cloud_queue,
                        color: isDone ? Colors.amberAccent : Colors.white38,
                      ),
                      title: Text(
                        weatherService.cities[index],
                        style: TextStyle(
                          color: isDone ? Colors.white : Colors.white60,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}