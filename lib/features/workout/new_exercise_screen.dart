import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class NewExerciseScreen extends StatefulWidget {
  final String category;

  const NewExerciseScreen({super.key, this.category = 'strength'});

  @override
  State<NewExerciseScreen> createState() => _NewExerciseScreenState();
}

class _NewExerciseScreenState extends State<NewExerciseScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const List<Map<String, String>> _strengthExercises = [
    {'name': 'Shoulder Press', 'muscle': 'Shoulders'},
    {'name': 'Tricep Extension', 'muscle': 'Triceps'},
    {'name': 'Lateral Raise', 'muscle': 'Shoulders'},
    {'name': 'Warm Up', 'muscle': 'Full Body'},
    {'name': 'Goblet Squat', 'muscle': 'Quadriceps'},
    {'name': 'Glute Bridge', 'muscle': 'Glutes'},
    {'name': 'Around The World', 'muscle': 'Chest'},
    {'name': 'Assisted Pistol World', 'muscle': 'Glutes'},
    {'name': 'Back Extension (Hyperextension)', 'muscle': 'Lower Back'},
    {'name': 'Back Extension (Machine)', 'muscle': 'Lower Back'},
    {'name': 'Back Extension (Weighted Hypertension)', 'muscle': 'Lower Back'},
    {'name': 'Ball Slams', 'muscle': 'Full Body'},
    {'name': 'Bench Press', 'muscle': 'Chest'},
    {'name': 'Bicep Curl', 'muscle': 'Biceps'},
    {'name': 'Cable Row', 'muscle': 'Back'},
    {'name': 'Deadlift', 'muscle': 'Full Body'},
    {'name': 'Dumbbell Row', 'muscle': 'Back'},
    {'name': 'Face Pull', 'muscle': 'Shoulders'},
    {'name': 'Hammer Curl', 'muscle': 'Biceps'},
    {'name': 'Incline Press', 'muscle': 'Chest'},
    {'name': 'Leg Press', 'muscle': 'Quadriceps'},
    {'name': 'Plank', 'muscle': 'Core'},
    {'name': 'Pull Up', 'muscle': 'Back'},
    {'name': 'Push Up', 'muscle': 'Chest'},
    {'name': 'Romanian Deadlift', 'muscle': 'Hamstrings'},
    {'name': 'Seated Calf Raise', 'muscle': 'Calves'},
    {'name': 'Seated Palms Up', 'muscle': 'Forearms'},
    {'name': 'Squat', 'muscle': 'Quadriceps'},
    {'name': 'Standing Calf', 'muscle': 'Calves'},
    {'name': 'Tricep Pushdown', 'muscle': 'Triceps'},
    {'name': 'Wrist Roller', 'muscle': 'Forearms'},
  ];

  static const List<Map<String, String>> _cardioExercises = [
    {'name': 'Treadmill', 'muscle': 'Full Body'},
    {'name': 'Stationary Bike', 'muscle': 'Leg'},
    {'name': 'Elliptical', 'muscle': 'Full Body'},
    {'name': 'Rowing Machine', 'muscle': 'Full Body'},
    {'name': 'Stair Climber', 'muscle': 'Leg'},
    {'name': 'Jump Rope', 'muscle': 'Leg'},
    {'name': 'Burpees', 'muscle': 'Full Body'},
    {'name': 'Jumping Jacks', 'muscle': 'Full Body'},
    {'name': 'Brisk Walking', 'muscle': 'Leg'},
    {'name': 'Cycling', 'muscle': 'Leg'},
    {'name': 'Swimming', 'muscle': 'Full Body'},
    {'name': 'High Knees', 'muscle': 'Full Body'},
    {'name': 'Mountain Climbers', 'muscle': 'Core'},
    {'name': 'Box Jumps', 'muscle': 'Leg'},
    {'name': 'Sprint Intervals', 'muscle': 'Full Body'},
    {'name': 'Dynamic Stretching', 'muscle': 'Full Body'},
    {'name': 'Light Jogging', 'muscle': 'Full Body'},
  ];

  List<Map<String, String>> get _allExercises =>
      widget.category == 'cardio' ? _cardioExercises : _strengthExercises;

  final List<Map<String, String>> _selected = [];

  List<Map<String, String>> get _filtered {
    if (_searchQuery.isEmpty) return _allExercises;
    final q = _searchQuery.toLowerCase();
    return _allExercises
        .where(
          (e) =>
              e['name']!.toLowerCase().contains(q) ||
              e['muscle']!.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: 220,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
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
                // App bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
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
                      const Text(
                        'NEW EXERCISE',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Search bar + filter
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(color: Colors.white),
                            onChanged: (v) =>
                                setState(() => _searchQuery = v),
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.textSecondary,
                                size: 22,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),

                // Exercise list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final exercise = _filtered[index];
                      final isSelected = _selected.contains(exercise);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selected.remove(exercise);
                            } else {
                              _selected.add(exercise);
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.15)
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exercise['name']!,
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      exercise['muscle']!,
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
                      );
                    },
                  ),
                ),

                // Add to Workout button
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selected.isEmpty
                          ? null
                          : () => Navigator.pop(context, _selected),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: AppColors.primary.withValues(
                          alpha: 0.45,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Add to Workout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
}
