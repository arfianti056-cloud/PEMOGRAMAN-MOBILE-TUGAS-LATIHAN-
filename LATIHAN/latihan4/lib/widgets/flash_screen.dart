import 'dart:async';

import 'package:flutter/material.dart';
import 'package:latihan4/auth/login_page.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
      );
      // Callback logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6366F1), Color(0xFF4F46E5), Color(0xFF4338CA)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              color: Colors.white,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.check),
            ),

            SizedBox(height: 15),

            Text(
              "Task Flow",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),

            Text(
              "Organize your tasks\n Achieve goals",
              style: TextStyle(color: Colors.white),
            ),

            SizedBox(height: 60),

            CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
