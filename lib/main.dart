import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'page/Screens/Welcome/welcome_screen.dart';
import 'page/Utama/home.dart';
import 'page/Utama/booking.dart';
import 'page/Utama/activity.dart';
import 'page/Utama/account.dart';
import 'bottomNavBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(
    const Duration(seconds: 4), // ini yang aslinya
    // Duration(seconds: 1),
  );
  FlutterNativeSplash.remove();
  // runApp(Login());
  runApp(MainApp());
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
  const MainApp({Key? key}) : super(key: key);
  @override
  MainAppState createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> 
{
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        // body: const HomePage(),
        body: linkPageUtama(selectedIndex),
        bottomNavigationBar: MyBottomNavigationBar
        (
          selectedIndex: selectedIndex,
          onItemTapped: onItemTapped,
        ),
      ),
    );
  }
  
  linkPageUtama(int idx) 
  {
    switch (idx) {
      case 0:
        {
          return const HomePage();
        }

      case 1:
        {
          return const BookingPage();
        }

      case 2:
        {
          return const ActivityPage();
        }

      case 3:
        {
          return const AccountPage();
        }
    }
  }
}
