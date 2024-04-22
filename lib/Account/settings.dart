import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const SettingsPage());
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      title: 'Settings',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 15, 71),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Color(0xFF202157),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0), //Set the height of the border
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Set the color of the border
                    width: 0.5, // Set the width of the border
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, // Set the color of the shadow
                    blurRadius: 2.0, // Set the blur radius of the shadow
                    offset: Offset(0.0, 2.0), // Set the offset of the shadow
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row( // Added Row widget for alignment to the left
                children: [
                  Text(
                    "General",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202157),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              InkWellButtonWithIcon(
                icon: Icons.public_outlined,
                text: "Language",
                // route: EditProfilePage(),
              ),
              SizedBox(height: 15),
              InkWellButtonWithIcon(
                icon: Icons.notifications_outlined,
                text: "Notifications",
                // route: MyOrdersPage(),
              ),
              SizedBox(height: 15),
              InkWellButtonWithIcon(
                icon: Icons.location_on_outlined,
                text: "Location Settings",
                // route: HelpSupportPage(),
              ),
              SizedBox(height: 30),
              Row( // Added Row widget for alignment to the left
                children: [
                  Text(
                    "Feedback",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202157),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              InkWellButtonWithIcon(
                icon: Icons.bug_report_outlined,
                text: "Report a Bug",
                // route: EditProfilePage(),
              ),
              SizedBox(height: 15),
              InkWellButtonWithIcon(
                icon: Icons.send_outlined,
                text: "Send Feedback",
                // route: MyOrdersPage(),
              ),
              SizedBox(height: 15),
              InkWellButtonWithIcon(
                icon: Icons.grade_outlined,
                text: "Rate Us on Google Play",
                // route: HelpSupportPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InkWellButtonWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  // final Widget route;

  const InkWellButtonWithIcon({
    required this.icon,
    required this.text,
    // required this.route,
  });

  @override
  Widget build(BuildContext context) {
    const iconColor = Color(0xFF51539B);

    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => route),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEBEBFF),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF202157),
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward,
              size: 20,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
