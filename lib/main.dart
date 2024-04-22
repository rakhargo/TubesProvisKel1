import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../Screens/Welcome/welcome_screen.dart';
import 'home.dart';
import 'booking.dart';
import 'activity.dart';
import 'account.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(
    // Duration(seconds: 4), // ini yang aslinya
    Duration(seconds: 1),
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
        primaryColor: Color(0xFF090F47),
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

class MainAppState extends State<MainApp> {
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
        body: case2(selectedIndex),
        bottomNavigationBar: MyBottomNavigationBar(
          selectedIndex: selectedIndex,
          onItemTapped: onItemTapped,
        ),
      ),
    );
  }
  
  case2(int idx) 
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

class MyBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  MyBottomNavigationBar({required this.selectedIndex, required this.onItemTapped});

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 24),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined, size: 24),
          label: 'Booking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.browse_gallery_outlined, size: 24),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined, size: 24),
          label: 'Account',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: const Color(0xff0F1035), // Change this to your preferred color
      unselectedItemColor: Colors.grey, // Set the unselected item color here
      showUnselectedLabels: true,
      onTap: widget.onItemTapped,
    );
  }
  
}

