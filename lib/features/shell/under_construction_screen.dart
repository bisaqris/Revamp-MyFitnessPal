import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_top_bar.dart';

class UnderConstructionScreen extends StatelessWidget {
  const UnderConstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            bottom: -60,
            left: -80,
            child: Container(
              width: 340,
              height: 340,
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
                const AppTopBar(),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.construction,
                              color: AppColors.primary,
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'UNDER CONSTRUCTION',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Fitur ini sedang dalam pengembangan.\nNantikan pembaruannya!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              height: 1.6,
                            ),
                          ),
                        ],
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
