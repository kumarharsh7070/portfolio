import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'home_screen.dart'; // Import home screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageSize = screenWidth * 0.5; // 50% of screen width (responsive)

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 4, 79, 185),
              Color.fromARGB(255, 16, 70, 170),
              Color.fromARGB(255, 35, 61, 112),
            ], // T // Dark Blue Gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Politician's Circular Avatar (Responsive)
                Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/politician.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ).animate().fade(duration: 1000.ms).scale(duration: 1000.ms),

                SizedBox(height: screenWidth * 0.05), // Responsive spacing
                // Politician's Name (Responsive Text)
                Text(
                      "Ashwani kumar",
                      style: TextStyle(
                        fontSize: screenWidth * 0.08, // Dynamic font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                    .animate()
                    .fade(duration: 1200.ms, delay: 300.ms)
                    .slideY(begin: 1.0, end: 0.0, duration: 800.ms),

                SizedBox(height: screenWidth * 0.02),

                // Slogan or Message (Responsive Text)
                Text(
                      "A Vision for the Future",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045, // Dynamic font size
                        fontStyle: FontStyle.italic,
                        color: Colors.white70,
                      ),
                    )
                    .animate()
                    .fade(duration: 1500.ms, delay: 500.ms)
                    .scale(duration: 800.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
