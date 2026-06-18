import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ActiveSet {
  final String previous;
  final double kg;
  final int reps;
  bool isDone;

  ActiveSet({
    required this.previous,
    required this.kg,
    required this.reps,
    this.isDone = true,
  });
}

class ActiveExercise {
  final String name;
  final String muscleGroup;
  final List<ActiveSet> sets;

  ActiveExercise({
    required this.name,
    required this.muscleGroup,
    required this.sets,
  });
}

class ActiveWorkoutScreen extends StatefulWidget {
  final String routineName;
  const ActiveWorkoutScreen({super.key, required this.routineName});

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  late final List<ActiveExercise> _exercises = [
    ActiveExercise(
      name: 'Shoulder Press',
      muscleGroup: 'Shoulders',
      sets: [
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
      ],
    ),
    ActiveExercise(
      name: 'Tricep Extension',
      muscleGroup: 'Triceps',
      sets: [
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
      ],
    ),
    ActiveExercise(
      name: 'Lateral Raise',
      muscleGroup: 'Shoulders',
      sets: [
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
      ],
    ),
    ActiveExercise(
      name: 'Warm Up',
      muscleGroup: 'Full Body',
      sets: [
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
        ActiveSet(previous: '5kg x 16', kg: 10, reps: 16),
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
            bottom: -80,
            right: -80,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFF8E00).withValues(alpha: 0.25),
                    const Color(0xFFFF8E00).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: _exercises
                          .map((e) => _buildExerciseCard(e))
                          .toList(),
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

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.chevron_left,
                color: AppColors.primary,
                size: 32,
              ),
            ),
          ),
          Text(
            widget.routineName,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(ActiveExercise exercise) {
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
          // Exercise header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      exercise.muscleGroup,
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
          const Divider(color: AppColors.border, height: 20),

          // Table header
          Row(
            children: const [
              Expanded(
                child: Text(
                  'Set',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Previous',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Kg',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Reps',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                width: 28,
                child: Icon(
                  Icons.check_box_outline_blank,
                  color: AppColors.primary,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Set rows
          ...List.generate(exercise.sets.length, (i) {
            final set = exercise.sets[i];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      set.previous,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      set.kg == set.kg.truncateToDouble()
                          ? set.kg.toInt().toString()
                          : '${set.kg}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${set.reps}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 28,
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => set.isDone = !set.isDone),
                      child: Icon(
                        set.isDone
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: AppColors.primary,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
