import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_top_bar.dart';
import 'workout_detail_screen.dart';
import 'active_workout_screen.dart';
import 'workout_models.dart';

class StrengthScreen extends StatefulWidget {
  const StrengthScreen({super.key});

  @override
  State<StrengthScreen> createState() => _StrengthScreenState();
}

class _StrengthScreenState extends State<StrengthScreen> {
  static const List<Routine> _routines = [
    Routine(
      name: 'FOREARMS',
      durationMin: 60,
      exercises: [
        'Warm up',
        'Seated Palms Up',
        'Standing Calf',
        'Wrist Roller',
        'Seated Calf Raise',
      ],
    ),
    Routine(
      name: 'FULL BODY',
      durationMin: 60,
      exercises: ['Warm up', 'Goblet Squat', 'Lateral Raise', 'Dumbbell Row', 'Plank'],
    ),
    Routine(
      name: 'CHEST SHOULDERS AND TRICEPS',
      durationMin: 60,
      exercises: [
        'Warm up',
        'Shoulder Press',
        'Tricep Extension',
        'Lateral Raise',
        'Seated Palm',
        'Bicep Curl',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: 160,
            right: -100,
            child: Container(
              width: 350,
              height: 350,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppTopBar(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
                  child: Text(
                    'STRENGTH',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'MY ROUTINE',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              '${_routines.length} ROUTINE',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ..._routines.map((r) => _buildRoutineCard(r)),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                _buildBottomButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineCard(Routine routine) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      routine.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${routine.durationMin}min',
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
                child: const Icon(Icons.more_horiz, color: Colors.white, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${routine.exercises.join(', ')}.',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ActiveWorkoutScreen(routineName: routine.name),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Start Routine',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WorkoutDetailScreen(title: 'STRENGTH', category: 'strength')),
              ),
              icon: const Icon(Icons.add, color: Colors.white, size: 18),
              label: const Text(
                'New Workout',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white, size: 18),
              label: const Text(
                'Explore',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
