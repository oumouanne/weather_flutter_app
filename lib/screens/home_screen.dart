import 'dart:async';
import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final WeatherService service = WeatherService();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // Mise à jour automatique toutes les 30 secondes
    timer = Timer.periodic(Duration(seconds: 30), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Météo - 5 Villes"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: service.cities.length,
        itemBuilder: (context, index) {

          String city = service.cities[index];

          return FutureBuilder<WeatherModel>(
            future: service.fetchWeather(city),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(city),
                    subtitle: Text("Chargement..."),
                    trailing: CircularProgressIndicator(),
                  ),
                );
              }

              else if (snapshot.hasError) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("❌ Impossible de récupérer les données"),
                    trailing: IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ),
                );
              }

              else if (snapshot.hasData) {

                final weather = snapshot.data!;

                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      "${weather.city} - ${weather.temperature}°C",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${weather.condition} | Humidité: ${weather.humidity}%",
                    ),
                    leading: Icon(Icons.cloud),
                  ),
                );
              }

              return SizedBox();
            },
          );
        },
      ),
    );
  }
}