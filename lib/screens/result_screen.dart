import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather_model.dart';
import '../services/weather_provider.dart';
import '../widgets/weather_table.dart';
import 'WeatherScreen.dart';
import 'city_detail_screen.dart';
import 'loading_screen.dart';


class ResultScreen extends StatelessWidget {
  final List<WeatherModel> weatherData;

  const ResultScreen({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final isDark = provider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text(
          '☁️ Météo en temps réel',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Colors.grey[900] : Colors.blue,
        actions: [
          IconButton(
            onPressed: provider.toggleDarkMode,
            icon: Icon(
              provider.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
          ),
        ],
      ),
      body: weatherData.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🔹 Tableau météo
            WeatherTable(
              weatherData: weatherData,
              onCityTap: (data) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CityDetailScreen(weatherData: data),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // 🔥 Bouton Recommencer
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoadingScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.refresh),
                label: const Text(
                  "Recommencer",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
