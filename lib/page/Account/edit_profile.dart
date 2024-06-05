import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medimate/provider/api/profile_api.dart';
import 'package:medimate/provider/model/profile_model.dart';
import 'dart:convert';

class EditProfilePage extends StatefulWidget {
  final String responseBody;
  final String profileId;
  const EditProfilePage({Key? key, required this.responseBody, required this.profileId}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage>
{
  Profile profile = Profile
  (
    id: "",
    userId: "",
    nama: "",
    tanggalLahir: "",
    jenisKelamin: "",
    alamat: "",
    noTelepon: "",
    email: "",
    userPhoto: ""
  );

  late String accessToken;
  late String userId;

  @override
  void initState() {
    super.initState();
    _initializeUserId();
    _initializeAccessToken();
    // _fetchHealthFacility(widget.healthFacilityId);
  }

  void _initializeUserId() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    userId = responseBodyMap['user_id'].toString();
  }

  void _initializeAccessToken() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    accessToken = responseBodyMap['access_token'];
  }

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Account Page',
      home: Scaffold
      (
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
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
              ),

              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'NAME',
                  labelStyle: TextStyle(
                    color: Color(0xFF202157),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7173BD)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF202157)),
                  ),
                  suffixIcon: Icon(
                    Icons.arrow_forward_ios, 
                    color: Color(0xFF7173BD),
                    size: 18,
                  ),
                ),
                // controller: TextEditingController(text: "John Doe"), // Set default text value
              ),

              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                    color: Color(0xFF202157),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7173BD)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF202157)),
                  ),
                  suffixIcon: Icon(
                    Icons.arrow_forward_ios, 
                    color: Color(0xFF7173BD),
                    size: 18,
                  ),
                ),
                // controller: TextEditingController(text: "John Doe"), // Set default text value
              ),

              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'PHONE NUMBER',
                  labelStyle: TextStyle(
                    color: Color(0xFF202157),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7173BD)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF202157)),
                  ),
                  suffixIcon: Icon(
                    Icons.arrow_forward_ios, 
                    color: Color(0xFF7173BD),
                    size: 18,
                  ),
                ),
                // controller: TextEditingController(text: "John Doe"), // Set default text value
              ),

              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'ADDRESS',
                  labelStyle: TextStyle(
                    color: Color(0xFF202157),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7173BD)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF202157)),
                  ),
                  suffixIcon: Icon(
                    Icons.arrow_forward_ios, 
                    color: Color(0xFF7173BD),
                    size: 18,
                  ),
                ),
                // controller: TextEditingController(text: "John Doe"), // Set default text value
              ),

              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'INSURANCE',
                  labelStyle: TextStyle(
                    color: Color(0xFF202157),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7173BD)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF202157)),
                  ),
                  suffixIcon: Icon(
                    Icons.arrow_forward_ios, 
                    color: Color(0xFF7173BD),
                    size: 18,
                  ),
                ),
                // controller: TextEditingController(text: "John Doe"), // Set default text value
              ),

            ],
          ),
        ),
      ),
    );
  }
}