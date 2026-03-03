
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Carte OpenStreetMap
import 'package:latlong2/latlong.dart';        // Classe LatLng pour FlutterMap
import '../models/weather_model.dart';        // Modèle météo
import '../theme/app_theme.dart';             // Thème de l'application

// WIDGET PRINCIPAL
class CityDetailScreen extends StatefulWidget {
  final WeatherModel weatherData; // Données météo de la ville

  const CityDetailScreen({super.key, required this.weatherData});

  @override
  State<CityDetailScreen> createState() => _CityDetailScreenState();
}


// STATE

class _CityDetailScreenState extends State<CityDetailScreen> {

  // BUILD
  @override
  Widget build(BuildContext context) {
    final weather = widget.weatherData;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // APP BAR AVEC IMAGE DE LA VILLE
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryLight,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${weather.city}, ${weather.country}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: _getWeatherGradient(weather.description),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        weather.iconUrl,
                        width: 80,
                        height: 80,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.wb_cloudy_rounded,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        weather.tempFormatted,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // CONTENU PRINCIPAL
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // DESCRIPTION METEO
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryLight.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              _getWeatherIcon(weather.description),
                              color: AppTheme.primaryLight,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weather.capitalizedDescription,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  // STATS MÉTÉO
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.4,
                    children: [
                      _buildStatCard(context, Icons.water_drop_rounded, 'Humidité', '${weather.humidity}%', Colors.blue),
                      _buildStatCard(context, Icons.air_rounded, 'Vent', '${weather.windSpeed} m/s', Colors.teal),
                      _buildStatCard(context, Icons.visibility_rounded, 'Visibilité', '${(weather.visibility / 1000).toStringAsFixed(1)} km', Colors.green),
                      _buildStatCard(context, Icons.wb_sunny_rounded, 'Lever / Coucher', '${_formatTime(weather.sunrise)} / ${_formatTime(weather.sunset)}', Colors.amber),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // SECTION CARTE
                  Text(
                    '📍 Localisation',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: SizedBox(
                      height: 280,
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(weather.lat, weather.lon),
                          zoom: 12,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.weather_app',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(weather.lat, weather.lon),
                                width: 40,
                                height: 40,
                                child: const Icon(
                                  Icons.location_on,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET POUR LES CARDS DE STAT
  Widget _buildStatCard(BuildContext context, IconData icon, String label, String value, Color color) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  // FONCTION POUR FORMATER HEURE
  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
  // FONCTION POUR GRADIENT FOND DYNAMIQUE
  List<Color> _getWeatherGradient(String description) {
    final desc = description.toLowerCase();
    if (desc.contains('pluie') || desc.contains('rain')) return [const Color(0xFF546E7A), const Color(0xFF90A4AE)];
    if (desc.contains('nuage') || desc.contains('cloud')) return [const Color(0xFF607D8B), const Color(0xFFB0BEC5)];
    if (desc.contains('soleil') || desc.contains('clear')) return [const Color(0xFFF57F17), const Color(0xFFFFCA28)];
    if (desc.contains('neige') || desc.contains('snow')) return [const Color(0xFF78909C), const Color(0xFFE0E0E0)];
    return [const Color(0xFF1565C0), const Color(0xFF42A5F5)];
  }
  // FONCTION POUR ICÔNES MÉTÉO
  IconData _getWeatherIcon(String description) {
    final desc = description.toLowerCase();
    if (desc.contains('pluie') || desc.contains('rain')) return Icons.umbrella_rounded;
    if (desc.contains('nuage') || desc.contains('cloud')) return Icons.cloud_rounded;
    if (desc.contains('neige') || desc.contains('snow')) return Icons.ac_unit_rounded;
    if (desc.contains('orage') || desc.contains('thunder')) return Icons.thunderstorm_rounded;
    return Icons.wb_sunny_rounded;
  }
}
