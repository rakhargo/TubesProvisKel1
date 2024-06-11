import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:medimate/page/Account/edit_profile.dart';
import 'package:medimate/page/CreateProfilePage.dart';
import 'package:medimate/page/Account/orders.dart';
import 'package:medimate/page/Account/settings.dart';
import 'package:medimate/page/Account/support.dart';
import 'package:medimate/page/Screens/Login/login_screen.dart';
import 'package:medimate/provider/model/profile_model.dart';
import 'package:medimate/provider/api/profile_api.dart';
import 'dart:convert';


class AccountPage extends StatefulWidget {
  final String responseBody;
  final String profileId;

  const AccountPage({Key? key, required this.responseBody, required this.profileId}) : super(key: key);
  @override
  State<AccountPage> createState() => _AccountState();
}

class _AccountState extends State<AccountPage> {

  late String accessToken;
  late String userId;

  @override
  void initState() {
    super.initState();
    _initializeUserId();
    _initializeAccessToken();
    _fetchProfile(widget.profileId);
  }

  void _initializeUserId() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    userId = responseBodyMap['user_id'].toString();
  }

  void _initializeAccessToken() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    accessToken = responseBodyMap['access_token'];
  }

  Profile chosenProfile = Profile
  (
    id: "",
    userId: "",
    nama: "",
    tanggalLahir: "",
    jenisKelamin: "",
    email: "",
    alamat: "",
    noTelepon: "",
    userPhoto: "",
    isMainProfile: "",
  );

  Future<void> _fetchProfile(String profileId) async {
    final profileResponse =
        await Provider.of<ProfileAPI>(context, listen: false)
            .fetchDataByProfileId(profileId, accessToken); // Pass the access token here
            // print(profileResponse);
    setState(() {
      chosenProfile = profileResponse;
      // print(profileResponse);
      // print("INI PROFILE");
      // print(chosenProfile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Consumer<ProfileAPI>
            (
              builder: (context, item, child)
              {
                return Column(
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
                        // child: Image.asset
                        // (
                        //   'assets/images/orang/1-John_Doe.jpg', // Replace with your image asset path
                        //   fit: BoxFit.cover, // Ensure the image covers the entire circle
                        //   width: 130, // Set width to match container width
                        //   height: 130, // Set height to match container height
                        // ),
                        child: FutureBuilder<dynamic>(
                        future: item.fetchImage(widget.profileId, accessToken),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Icon(Icons.error);
                          } else if (snapshot.hasData) {
                            return Image.memory(
                              snapshot.data!.bodyBytes,
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                            );
                          } else {
                            // Show a placeholder if no data is available
                            return const Placeholder();
                          }
                        },
                      ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      chosenProfile.nama,
                      style: const TextStyle(
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
                      child: Center(
                        child: Text(
                          chosenProfile.email,
                          style: TextStyle(
                            color: Color(0xD9202157), // Change text color as needed
                            fontSize: 15, // Adjust font size as needed
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    InkWellButtonWithIcon(
                      icon: Icons.edit_outlined,
                      text: "Edit Profile",
                      route: EditProfilePage(responseBody: widget.responseBody, profileId: widget.profileId,),
                    ),
                    const SizedBox(height: 15),
                    InkWellButtonWithIcon(
                      icon: Icons.receipt_long_outlined,
                      text: "My Orders",
                      route: MyOrdersPage(responseBody: widget.responseBody, profileId: widget.profileId),
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
                    InkWellButtonWithIcon(
                      icon: Icons.group_outlined,
                      text: "Add Family Member",
                      route: CreateProfilePage(responseBody: widget.responseBody, profileId: widget.profileId,),
                    ),
                    const SizedBox(height: 15),
                    InkWellButtonWithIcon(
                      icon: Icons.logout_outlined,
                      text: "Logout",
                      route: LoginScreen(), // Assuming LoginPage is your login page route
                    ),
                  ],
                );
              }
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