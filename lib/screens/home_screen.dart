import 'package:flutter/material.dart';
import 'loading_screen.dart'; // Pour naviguer vers l’écran de chargement
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1️⃣ Message d’introduction
            const Text(
              '🌤️ Bienvenue dans Weather App ! 🌤️',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 40),

            // 2️⃣ Bouton "Commencer l’expérience"
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoadingScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent,
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              child: const Text('Commencer l’expérience'),
            ),
          ],
        ),
      ),
    );
  }
}