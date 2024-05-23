import 'package:flutter/material.dart';
import 'package:medimate/page/Screens/Welcome/welcome_screen.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medimate',
      theme: ThemeData(
        primaryColor: const Color(0xFF090F47),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}