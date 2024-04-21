import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() 
{
  runApp(const AccountPage());
}

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountState();
}

class _AccountState extends State<AccountPage>
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Account Page',
      home: Scaffold
      (
        appBar: AppBar
        (
          title: const Text
          (
            'My Profile',
            style: TextStyle
            (
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 15, 71),
            ),
          ),
          bottom: PreferredSize
          (
            preferredSize: const Size.fromHeight(2.0), //Set the height of the border
            child: Container
            (
              decoration: const BoxDecoration
              (
                border: Border
                (
                  bottom: BorderSide
                  (
                    color: Colors.grey, // Set the color of the border
                    width: 0.5, // Set the width of the border
                  ),
                ),
                boxShadow: 
                [
                  BoxShadow
                  (
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue, // Change color as needed
                ),
                child: ClipOval(
                  child: Image.asset(
                    'images/orang/noah-clark.jpg', // Replace with your image asset path
                    fit: BoxFit.cover, // Ensure the image covers the entire circle
                    width: 130, // Set width to match container width
                    height: 130, // Set height to match container height
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "John Doe",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF202157),
                ),
              ),
              const SizedBox(height: 10),

              Container(
                width: 180,
                height: 35,
                decoration: BoxDecoration(
                  color: const Color(0xCC9799DF),
                  borderRadius: BorderRadius.circular(20), // Adjust the radius to your preference
                ),
                child: const Center(
                  child: Text(
                    'Johndoe@email.com',
                    style: TextStyle(
                      color: Color(0xD9202157), // Change text color as needed
                      fontSize: 15, // Adjust font size as needed
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
              const TextButtonWithIcon(icon: Icons.edit_outlined, text: "Edit Profile"),
              const SizedBox(height: 15),
              const TextButtonWithIcon(icon: Icons.receipt_long_outlined, text: "My Orders"),
              const SizedBox(height: 15),
              const TextButtonWithIcon(icon: Icons.support_agent_outlined, text: "Help and Support"),
              const SizedBox(height: 15),
              const TextButtonWithIcon(icon: Icons.settings_outlined, text: "Settings"),
              const SizedBox(height: 15),
              const TextButtonWithIcon(icon: Icons.group_outlined, text: "Add Family Member"),
              const SizedBox(height: 15),
              const TextButtonWithIcon(icon: Icons.logout_outlined, text: "Logout"),
            ],
          ),
        ),
      ),
    );
  }
}

class TextButtonWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const TextButtonWithIcon({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLogout = text == "Logout"; // Check if text is "Logout"
    final iconColor1 = isLogout ? const Color(0xFFD84339) : const Color(0xFF51539B);
    final iconColor2 = isLogout ? const Color(0xFFD84339) : const Color(0xFF202157);

    return TextButton(
      onPressed: () {
        // Add functionality here
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFFEBEBFF)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: iconColor1,
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
            color: iconColor2,
          ),
        ],
      ),
    );
  }
}