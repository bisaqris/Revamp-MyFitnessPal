import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_top_bar.dart';
import '../workout/strength_screen.dart';
import '../workout/cardio_screen.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  final List<Map<String, dynamic>> _lastExercises = const [
    {
      'name': 'UPPER-BACK',
      'duration': '60min',
      'sets': 14,
      'exercises': 4,
      'volume': '2.150KG',
    },
    {
      'name': 'LEG-DAY',
      'duration': '60min',
      'sets': 8,
      'exercises': 5,
      'volume': '1.800KG',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            bottom: 60,
            left: -80,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFF8E00).withValues(alpha: 0.22),
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
                        _buildActiveWorkoutCard(),
                        const SizedBox(height: 16),
                        _buildCategoriesSection(context),
                        const SizedBox(height: 16),
                        _buildLastExerciseSection(),
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

  Widget _buildActiveWorkoutCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ACTIVE WORKOUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const Text(
                      'MORNING CARDIO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Warm up  •  Walk  •  Run',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    '28:42',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Elapsed',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildWorkoutStat('320', 'Calories'),
              const SizedBox(width: 10),
              _buildWorkoutStat('3', 'Exercises'),
              const SizedBox(width: 10),
              _buildWorkoutStat('25KM', 'Distance'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutStat(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
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
            'CATEGORIES',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildCategoryCard(
                  context: context,
                  icon: Icons.monitor_weight,
                  title: 'Cardio',
                  subtitle: 'Fat loss, gain energy',
                  destination: const CardioScreen(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildCategoryCard(
                  context: context,
                  icon: Icons.fitness_center,
                  title: 'Strength',
                  subtitle: 'Gain muscle, more weight',
                  destination: const StrengthScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget destination,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => destination),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 26),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastExerciseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LAST EXERCISE',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        ..._lastExercises.map((e) => _buildLastExerciseCard(e)),
      ],
    );
  }

  Widget _buildLastExerciseCard(Map<String, dynamic> exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise['name'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      exercise['duration'] as String,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildExerciseStat('${exercise['sets']}', 'Sets'),
              const SizedBox(width: 8),
              _buildExerciseStat('${exercise['exercises']}', 'Excercise'),
              const SizedBox(width: 8),
              _buildExerciseStat('${exercise['volume']}', 'Volume'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseStat(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }

}
