import 'dart:async';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progress = 0.0;
  String _message = "Initialisation...";
  late Timer _timer;

  final List<String> _messages = [
    "📡 Récupération des données météo...",
    "🌍 Localisation en cours...",
    "☁️ Analyse des nuages...",
    "🌤️ Presque terminé...",
  ];

  int _messageIndex = 0;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        _progress += 0.05;

        if (_progress >= 1.0) {
          _progress = 1.0;
          _message = "✅ Chargement terminé !";
          timer.cancel();
        } else {
          _message = _messages[_messageIndex];
          _messageIndex = (_messageIndex + 1) % _messages.length;
        }
      });
    });
  }

  void _restart() {
    setState(() {
      _progress = 0.0;
      _messageIndex = 0;
    });
    _startLoading();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(value: _progress),
              const SizedBox(height: 30),
              Text(
                _message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              if (_progress == 1.0)
                ElevatedButton(
                  onPressed: _restart,
                  child: const Text("Recommencer"),
                )
            ],
          ),
        ),
      ),
    );
  }
}

