import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

import 'features/onboarding/splash.dart';
import 'features/onboarding/onboarding_screen.dart';

void main() {
  runApp(const FitnesPalApp());
}

class FitnesPalApp extends StatelessWidget {
  const FitnesPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Pal',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.darkTheme,

      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
      },
    );
  }
}