import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to login after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E7D32),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.agriculture,
                size: 70,
                color: Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(height: 30),
            
            // App Name
            const Text(
              'GrowMate',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            
            // Tagline
            const Text(
              'Smart Farming Companion',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                letterSpacing: 1.2,
              ),
            ),
            
            const SizedBox(height: 50),
            
            // Loading Indicator
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
            
            const SizedBox(height: 20),
            
            // Loading Text
            const Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}