class WeatherModel {
  final String city;
  final double temperature;
  final String condition;
  final int humidity;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'] ?? "Ville inconnue",
      temperature: (json['main']['temp'] ?? 0).toDouble(),
      condition: json['weather'][0]['main'] ?? "Inconnu",
      humidity: json['main']['humidity'] ?? 0,
    );
  }
}