import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:medimate/Onboboarding/onboarding_view.dart';
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
        home: onboarding ? const MainApp() : const OnboardingView(),
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

class MainAppState extends State<MainApp> 
{
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

// providers: 
//       [
//         // ChangeNotifierProvider(create: (_) => AuthAPI()),
//         // ChangeNotifierProvider(create: (_) => ItemList()),
//         // ChangeNotifierProvider(create: (_) => CartList()),
//         // ChangeNotifierProvider(create: (_) => Pembayaran()),
//       ],
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
