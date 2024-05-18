import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:medimate/Onboboarding/onboarding_view.dart';
import 'package:medimate/provider/api/specialistAndPoliclinic_api.dart';
import 'package:medimate/provider/model/specialistAndPolyclinic_model.dart';
import 'page/Screens/Welcome/welcome_screen.dart';
import 'page/Utama/home.dart';
import 'page/Utama/booking.dart';
import 'page/Utama/activity.dart';
import 'page/Utama/account.dart';
import 'bottomNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void boarding() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;

  runApp(MyBoarding(onboarding: onboarding));
}

class MyBoarding extends StatelessWidget {
  final bool onboarding;
  const MyBoarding({Key? key, required this.onboarding}) : super(key: key);

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
        home: onboarding ? Login() : const OnboardingView(),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  await Future.delayed(const Duration(seconds: 4)); // Adjust as needed
  FlutterNativeSplash.remove();

  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;
  runApp(MyBoarding(onboarding: onboarding));
}

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

class MainApp extends StatefulWidget {
  final String responseBody;

  const MainApp({Key? key, required this.responseBody}) : super(key: key);

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SpecialistAndPolyclinicList()),
        // ChangeNotifierProvider(create: (_) => ItemList()),
        // ChangeNotifierProvider(create: (_) => CartList()),
        // ChangeNotifierProvider(create: (_) => Pembayaran()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: linkPageUtama(selectedIndex),
          bottomNavigationBar: MyBottomNavigationBar(
            selectedIndex: selectedIndex,
            onItemTapped: onItemTapped,
          ),
        ),
      ),
    );
  }

  Widget linkPageUtama(int idx) {
    switch (idx) {
      case 0:
        return HomePage(responseBody: widget.responseBody);
      case 1:
        return BookingPage(responseBody: widget.responseBody);
      case 2:
        return ActivityPage(responseBody: widget.responseBody);
      case 3:
        return AccountPage(responseBody: widget.responseBody);
      default:
        return HomePage(responseBody: widget.responseBody);
    }
  }
}
