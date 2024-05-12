import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:medimate/Onboboarding/onboarding_view.dart';
import '../Screens/Welcome/welcome_screen.dart';
import 'home.dart';
import 'booking.dart';
import 'activity.dart';
import 'account.dart';
import 'package:shared_preferences/shared_preferences.dart';

void boarding() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding")??false;

  runApp( MyBoarding(onboarding: onboarding));
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
        home: onboarding ? const HomePage() : const OnboardingView(),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  // Menambahkan penundaan untuk menampilkan splash screen selama beberapa detik
  await Future.delayed(const Duration(seconds: 4)); // Atur sesuai kebutuhan
  
  // Menghilangkan splash screen
  FlutterNativeSplash.remove();
  
  // Menampilkan halaman onboarding atau halaman utama tergantung dari kondisi onboarding
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

