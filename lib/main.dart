import 'package:crm_system/ui/screen/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRM System',
      theme: ThemeData(fontFamily: "Nunito Sans"),
      home: const SignUpScreen(),
    );
  }
}
