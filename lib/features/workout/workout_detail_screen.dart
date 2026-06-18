import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'new_exercise_screen.dart';

class WorkoutExercise {
  final String name;
  final String muscleGroup;
  List<ExerciseSet> sets;
  bool isExpanded;

  WorkoutExercise({
    required this.name,
    required this.muscleGroup,
    List<ExerciseSet>? sets,
    this.isExpanded = false,
  }) : sets = sets ?? [ExerciseSet()];
}

class ExerciseSet {
  double kg;
  int reps;
  bool isDone;
  ExerciseSet({this.kg = 0, this.reps = 0, this.isDone = false});
}

class WorkoutDetailScreen extends StatefulWidget {
  final String title;
  final String category;

  const WorkoutDetailScreen({
    super.key,
    this.title = 'STRENGTH',
    this.category = 'strength',
  });

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  final List<WorkoutExercise> _exercises = [];

  Future<void> _navigateToAddExercise() async {
    final result = await Navigator.push<List<Map<String, String>>>(
      context,
      MaterialPageRoute(
        builder: (_) => NewExerciseScreen(category: widget.category),
      ),
    );
    if (result != null && result.isNotEmpty) {
      setState(() {
        for (final e in result) {
          _exercises.add(
            WorkoutExercise(name: e['name']!, muscleGroup: e['muscle']!),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            bottom: -80,
            left: -60,
            child: Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFF8E00).withValues(alpha: 0.28),
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
                  child: _exercises.isEmpty
                      ? _buildEmptyState()
                      : _buildExerciseList(),
                ),
                _buildBottomButtons(),
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
            widget.title,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.fitness_center,
                color: AppColors.primary,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Get Started',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add an excercise to start your workout',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Column(
        children: List.generate(_exercises.length, (i) {
          final exercise = _exercises[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () =>
                      setState(() => exercise.isExpanded = !exercise.isExpanded),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                    child: Row(
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
                  ),
                ),
                if (exercise.isExpanded)
                  _buildSetsTable(i, exercise),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSetsTable(int exerciseIndex, WorkoutExercise exercise) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: Column(
        children: [
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          // Header row
          Row(
            children: [
              const SizedBox(width: 30),
              const Expanded(
                child: Text(
                  'Set',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
              const Expanded(
                child: Text(
                  'Previous',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
              const Expanded(
                child: Text(
                  'Kg',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
              const Expanded(
                child: Text(
                  'Reps',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
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
          ...List.generate(exercise.sets.length, (setIndex) {
            final set = exercise.sets[setIndex];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(
                      () => exercise.sets.removeAt(setIndex),
                    ),
                    child: const SizedBox(
                      width: 30,
                      child: Icon(
                        Icons.delete_outline,
                        color: AppColors.textSecondary,
                        size: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${setIndex + 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      '0',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      set.kg == 0 ? '0' : '${set.kg}',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${set.reps}',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
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
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () =>
                  setState(() => exercise.sets.add(ExerciseSet())),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Add Set',
                style: TextStyle(
                  color: Colors.white,
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
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _navigateToAddExercise,
              icon: const Icon(Icons.add, color: Colors.white, size: 18),
              label: const Text(
                'Add Exercise',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
          if (_exercises.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Work Out as Routine',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
