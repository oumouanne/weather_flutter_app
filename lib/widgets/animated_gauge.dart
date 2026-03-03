// lib/widgets/animated_gauge.dart

import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedGauge extends StatelessWidget {
  final double progress;
  final int citiesCount;
  final int loadedCount;

  const AnimatedGauge({
    super.key,
    required this.progress,
    required this.citiesCount,
    required this.loadedCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Gauge painter
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            builder: (_, value, __) {
              return CustomPaint(
                painter: _GaugePainter(progress: value),
                size: const Size(200, 200),
              );
            },
          ),
          // Center content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress * 100),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                builder: (_, value, __) {
                  return Text(
                    '${value.round()}%',
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              Text(
                '$loadedCount / $citiesCount villes',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;

  _GaugePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const startAngle = -math.pi * 0.8;
    const sweepAngle = math.pi * 1.6;

    // Background arc
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    // Progress arc
    if (progress > 0) {
      final progressPaint = Paint()
        ..shader = const SweepGradient(
          colors: [Color(0xFF64B5F6), Color(0xFF4CAF50)],
          startAngle: 0,
          endAngle: math.pi * 2,
        ).createShader(Rect.fromCircle(center: center, radius: radius))
        ..strokeWidth = 16
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle * progress,
        false,
        progressPaint,
      );

      // Dot at the end
      final angle = startAngle + sweepAngle * progress;
      final dotX = center.dx + radius * math.cos(angle);
      final dotY = center.dy + radius * math.sin(angle);

      final dotPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(dotX, dotY), 8, dotPaint);

      final dotInnerPaint = Paint()
        ..color = const Color(0xFF4CAF50)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(dotX, dotY), 4, dotInnerPaint);
    }

    // Outer glow ring
    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius + 20, glowPaint);
  }

  @override
  bool shouldRepaint(_GaugePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
