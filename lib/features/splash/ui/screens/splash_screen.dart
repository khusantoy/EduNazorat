// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6a3de8),
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
