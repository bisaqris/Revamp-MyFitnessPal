import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: 80,
            right: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFF8E00).withValues(alpha: 0.2),
                    const Color(0xFFFF8E00).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const AppTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        _buildCaloriesCard(),
                        const SizedBox(height: 16),
                        _buildPreviousWorkoutCard(),
                        const SizedBox(height: 16),
                        _buildDiscoverSection(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaloriesCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CALORIES',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 155,
                height: 155,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(155, 155),
                      painter: _CalorieRingPainter(progress: 1.0),
                    ),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '2.440',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'Remaining',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCalorieStat('Base Goal', '2.440'),
                    const SizedBox(height: 14),
                    _buildCalorieStat('Food', '0'),
                    const SizedBox(height: 14),
                    _buildCalorieStat('Excercise', '0'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalorieStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget _buildPreviousWorkoutCard() {
    final workouts = [
      {'name': 'Warm up', 'value': '1 menit'},
      {'name': 'Walk', 'value': '200m'},
      {'name': 'Run', 'value': '25km'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LATIHAN SEBELUMNYA',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          const Text(
            'Cardio',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ...workouts.map(
            (item) => _buildWorkoutItem(item['name']!, item['value']!),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutItem(String name, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          const Text(
            '• ',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoverSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DISCOVER',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildDiscoverItem(Icons.content_paste)),
              const SizedBox(width: 12),
              Expanded(child: _buildDiscoverItem(Icons.groups)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoverItem(IconData icon) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
      ),
    );
  }
}

class _CalorieRingPainter extends CustomPainter {
  final double progress;

  const _CalorieRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 12;

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    final progressPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CalorieRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
