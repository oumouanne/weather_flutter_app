// lib/widgets/weather_table.dart

import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../theme/app_theme.dart';

class WeatherTable extends StatelessWidget {
  final List<WeatherModel> weatherData;
  final Function(WeatherModel) onCityTap;

  const WeatherTable({
    super.key,
    required this.weatherData,
    required this.onCityTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            '🌍 Résultats météo',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...weatherData.asMap().entries.map((entry) {
          final index = entry.key;
          final data = entry.value;
          return _WeatherCard(
            data: data,
            onTap: () => onCityTap(data),
            delay: Duration(milliseconds: 100 * index),
          );
        }),
      ],
    );
  }
}

class _WeatherCard extends StatefulWidget {
  final WeatherModel data;
  final VoidCallback onTap;
  final Duration delay;

  const _WeatherCard({
    required this.data,
    required this.onTap,
    required this.delay,
  });

  @override
  State<_WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<_WeatherCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    // Weather icon
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _getTempColor(widget.data.temperature)
                            .withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.network(
                        widget.data.iconUrl,
                        width: 48,
                        height: 48,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.wb_cloudy_rounded,
                          color: _getTempColor(widget.data.temperature),
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    // City info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.data.city,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryLight.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  widget.data.country,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.primaryLight,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.data.capitalizedDescription,
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.water_drop_rounded,
                                  size: 13, color: Colors.blue[300]),
                              Text(
                                ' ${widget.data.humidity}%',
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(width: 10),
                              Icon(Icons.air_rounded,
                                  size: 13, color: Colors.teal[300]),
                              Text(
                                ' ${widget.data.windSpeed} m/s',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Temperature
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.data.tempFormatted,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: _getTempColor(widget.data.temperature),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getTempColor(double temp) {
    if (temp < 0) return Colors.blue[800]!;
    if (temp < 10) return Colors.blue;
    if (temp < 20) return Colors.teal;
    if (temp < 28) return Colors.green;
    if (temp < 35) return Colors.orange;
    return Colors.red;
  }
}
