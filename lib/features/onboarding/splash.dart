import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {

      print("Pindah ke halaman Onboarding");
      Navigator.pushReplacementNamed(context, '/onboarding');

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFFFF8C00),
                shape: BoxShape.circle,
              ),
              child: Center(
                child:Image.asset('assets/images/logo.png',
                width: 60,
                height:60,
                fit: BoxFit.contain
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}