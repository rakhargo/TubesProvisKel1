import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medimate/page/Account/edit_profile.dart';
import 'package:medimate/page/Account/add_family.dart';
import 'package:medimate/page/Account/orders.dart';
import 'package:medimate/page/Account/settings.dart';
import 'package:medimate/page/Account/support.dart';
import 'package:medimate/page/Screens/Login/login_screen.dart';
import 'package:medimate/bottomNavBar.dart';

void main() 
{
  runApp(const AccountPage());
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountState();
}

class _AccountState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Account Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 15, 71),
            ),
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
        body: SingleChildScrollView
        (
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
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
                      'assets/images/orang/1-John_Doe.jpg', // Replace with your image asset path
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
                const InkWellButtonWithIcon(
                  icon: Icons.edit_outlined,
                  text: "Edit Profile",
                  route: EditProfilePage(),
                ),
                const SizedBox(height: 15),
                const InkWellButtonWithIcon(
                  icon: Icons.receipt_long_outlined,
                  text: "My Orders",
                  route: MyOrdersPage(),
                ),
                const SizedBox(height: 15),
                const InkWellButtonWithIcon(
                  icon: Icons.support_agent_outlined,
                  text: "Help and Support",
                  route: HelpSupportPage(),
                ),
                const SizedBox(height: 15),
                const InkWellButtonWithIcon(
                  icon: Icons.settings_outlined,
                  text: "Settings",
                  route: SettingsPage(),
                ),
                const SizedBox(height: 15),
                const InkWellButtonWithIcon(
                  icon: Icons.group_outlined,
                  text: "Add Family Member",
                  route: AddFamilyMemberPage(),
                ),
                const SizedBox(height: 15),
                InkWellButtonWithIcon(
                  icon: Icons.logout_outlined,
                  text: "Logout",
                  route: LoginScreen(), // Assuming LoginPage is your login page route
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class InkWellButtonWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget route;

  const InkWellButtonWithIcon({
    required this.icon,
    required this.text,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final isLogout = text == "Logout"; // Check if text is "Logout"
    final iconColor1 = isLogout ? const Color(0xFFD84339) : const Color(0xFF51539B);
    final iconColor2 = isLogout ? const Color(0xFFD84339) : const Color(0xFF202157);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
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
      ),
    );
  }
}