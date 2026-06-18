import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background glow decoration
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 350,
              height: 350,
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
                        'NOTIFICATION',
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

                // Empty state content
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.05),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.notifications_outlined,
                                color: AppColors.primary,
                                size: 36,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'No recent notifications',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "We'll notify you when you have new activity\nor reminder",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
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
