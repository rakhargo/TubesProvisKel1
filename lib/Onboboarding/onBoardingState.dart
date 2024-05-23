import 'package:flutter/material.dart';
import 'onboarding_view.dart';
import 'package:medimate/main.dart';
import 'package:medimate/page/Screens/Login/loginState.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class MyBoarding extends StatelessWidget {
  // final bool onboarding;
  // const MyBoarding({Key? key, required this.onboarding}) : super(key: key);
  const MyBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Adjust according to your text direction
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medimate',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: onboarding ? Login() : const OnboardingView(),
        home: OnboardingView(),
        // initialRoute: onboarding ? '/' : '/login', // Sesuaikan rute awal
        // initialRoute: '/', // Sesuaikan rute awal
        // routes: routes, // Gunakan rute dari file routes.dart
      ),
    );
  }
}