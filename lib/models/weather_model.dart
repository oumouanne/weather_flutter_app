class WeatherModel {
  final String city;
<<<<<<< HEAD
  final String country;
  final double temperature;
  final String condition;
  final int humidity;
  final String icon;
  final double windSpeed;
  final String description;
  final DateTime sunrise;
  final DateTime sunset;
  final double lat;
  final double lon;
  final int visibility;

  WeatherModel({
    required this.city,
    required this.country,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.icon,
    required this.windSpeed,
    required this.description,
    required this.sunrise,
    required this.sunset,
    required this.lat,
    required this.lon,
    required this.visibility
=======
  final double temperature;
  final String condition;
  final int humidity;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
>>>>>>> 1fa7db75dc559c594d9bf2a0be2a97d550e3886a
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'] ?? "Ville inconnue",
<<<<<<< HEAD
      country: json['sys']['country'] ?? '',
      temperature: (json['main']?['temp'] ?? 0).toDouble(),
      condition: json['weather']?[0]?['main'] ?? "Inconnu",
      humidity: json['main']?['humidity'] ?? 0,
      icon: json['weather'][0]['icon'] ?? '',
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      sunrise: DateTime.fromMillisecondsSinceEpoch(
          (json['sys']['sunrise'] as int) * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(
          (json['sys']['sunset'] as int) * 1000),
      lat: (json['coord']['lat'] as num).toDouble(),
      lon: (json['coord']['lon'] as num).toDouble(),
      visibility: (json['visibility'] ?? 10000) as int,
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
  String get tempFormatted => '${temperature.round()}°C';
  String get capitalizedDescription =>
      description.isEmpty ? '' : description[0].toUpperCase() + description.substring(1);
}
=======
      temperature: (json['main']?['temp'] ?? 0).toDouble(),
      condition: json['weather']?[0]?['main'] ?? "Inconnu",
      humidity: json['main']?['humidity'] ?? 0,
    );
  }
}
>>>>>>> 1fa7db75dc559c594d9bf2a0be2a97d550e3886a
