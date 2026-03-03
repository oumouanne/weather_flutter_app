import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:provider/provider.dart';
import '../models/weather_model.dart';
import '../services/weather_provider.dart';
import '../widgets/weather_table.dart';
import 'WeatherScreen.dart';
import 'city_detail_screen.dart';
import 'loading_screen.dart';


=======
import '../models/weather_model.dart';
import 'loading_screen.dart';
//la page ou il va afficher ce que khady a fait les api leur meteos ect-- des villes
>>>>>>> 1fa7db75dc559c594d9bf2a0be2a97d550e3886a
class ResultScreen extends StatelessWidget {
  final List<WeatherModel> weatherData;

  const ResultScreen({
    super.key,
    required this.weatherData,
  });

<<<<<<< HEAD
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
=======
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
>>>>>>> 1fa7db75dc559c594d9bf2a0be2a97d550e3886a
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 1fa7db75dc559c594d9bf2a0be2a97d550e3886a
