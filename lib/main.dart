import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:medimate/Onboboarding/onboarding_view.dart';
import 'package:medimate/provider/api/profile_api.dart';
import 'package:medimate/provider/api/specialistAndPoliclinic_api.dart';
import 'package:medimate/provider/api/healthFacility_api.dart';
import 'package:medimate/provider/api/appointment_api.dart';
import 'package:medimate/provider/api/doctor_api.dart';

import 'package:medimate/provider/model/profile_model.dart';
import 'package:medimate/provider/model/specialistAndPolyclinic_model.dart';
import 'package:medimate/provider/model/healthFacility_model.dart';
import 'package:medimate/provider/model/appointment_model.dart';
import 'package:medimate/provider/model/doctor_model.dart';

import 'page/Screens/Welcome/welcome_screen.dart';
import 'page/Utama/home.dart';
import 'page/Utama/booking.dart';
import 'page/Utama/activity.dart';
import 'page/Utama/account.dart';
import 'Onboboarding/onBoardingState.dart';
import 'bottomNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

// void boarding() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final onboarding = prefs.getBool("onboarding") ?? false;

//   runApp(MyBoarding(onboarding: onboarding));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Future.delayed(const Duration(seconds: 4)); // Adjust as needed
  FlutterNativeSplash.remove();

  // final prefs = await SharedPreferences.getInstance();
  // final onboarding = prefs.getBool("onboarding") ?? false;
  runApp(MyBoarding());
}

class MainApp extends StatefulWidget {
  final String responseBody;
  int indexNavbar;
  final String profileId;

  MainApp(
      {Key? key,
      required this.responseBody,
      required this.indexNavbar,
      required this.profileId})
      : super(key: key);

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  // int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      widget.indexNavbar = index;
      // selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SpecialistAndPolyclinicAPI()),
        ChangeNotifierProvider(create: (_) => ProfileAPI()),
        ChangeNotifierProvider(create: (_) => HealthFacilityAPI()),
        ChangeNotifierProvider(create: (_) => DoctorAPI()),
        ChangeNotifierProvider(create: (_) => AppointmentAPI()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: linkPageUtama(widget.indexNavbar),
          bottomNavigationBar: MyBottomNavigationBar(
            selectedIndex: widget.indexNavbar,
            onItemTapped: onItemTapped,
          ),
        ),
      ),
    );
  }

  Widget linkPageUtama(int idx) {
    switch (idx) {
      case 0:
        return HomePage(
          responseBody: widget.responseBody,
          profileId: widget.profileId,
        );
      case 1:
        return BookingPage(
          responseBody: widget.responseBody,
          profileId: widget.profileId,
        );
      case 2:
        return ActivityPage(
            responseBody: widget.responseBody, profileId: widget.profileId);
      case 3:
        return AccountPage(
            responseBody: widget.responseBody, profileId: widget.profileId);
      default:
        return HomePage(
          responseBody: widget.responseBody,
          profileId: widget.profileId,
        );
    }
  }
}
