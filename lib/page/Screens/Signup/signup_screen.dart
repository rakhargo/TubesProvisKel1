import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Login/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:medimate/provider/api/profile_api.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  TextEditingController _namaController = TextEditingController();
  TextEditingController _tanggallahirController = TextEditingController();
  String? _selectedGender;
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _notelpController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Color _signupButtonColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            "assets/icons/back.svg",
            fit: BoxFit.scaleDown,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 34, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Create your account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Color(0xFF090F47),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Account Details",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF090F47),
                ),
              ),
              Container(
                width: size.width * 0.8,
                child: TextField(
                  controller: _emailController,
                  onChanged: (_) => _updateSignupButtonColor(),
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width * 0.8,
                child: TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  onChanged: (_) => _updateSignupButtonColor(),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      child: Icon(
                        _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: const Color(0xFF090F47).withOpacity(0.45),
                        size: 24,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF090F47),
                ),
              ),
              Container(
                width: size.width * 0.8,
                child: TextField(
                  controller: _namaController,
                  onChanged: (_) => _updateSignupButtonColor(),
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    hintStyle: TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width * 0.8,
                child: TextField(
                  controller: _tanggallahirController,
                  onTap: () => _selectDate(context),
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Enter your birth date",
                    hintStyle: TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width * 0.8,
                child: DropdownButtonFormField<String>(
                  value: _selectedGender,
                  items: ['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                      _updateSignupButtonColor();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Select your gender",
                    hintStyle: TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width * 0.8,
                child: TextField(
                  controller: _alamatController,
                  onChanged: (_) => _updateSignupButtonColor(),
                  decoration: InputDecoration(
                    hintText: "Enter your address",
                    hintStyle: TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: size.width * 0.8,
                child: TextField(
                  controller: _notelpController,
                  onChanged: (_) => _updateSignupButtonColor(),
                  decoration: InputDecoration(
                    hintText: "Enter your mobile number",
                    hintStyle: TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: _signupButtonColor == Colors.grey ? null : _signup,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                      backgroundColor: _signupButtonColor,
                    ),
                    child: Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF202157).withOpacity(0.45),
                    ),
                    children: [
                      TextSpan(
                        text: "Log in",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF202157).withOpacity(0.7),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => LoginScreen(),
                                transitionsBuilder: (_, animation, __, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(1.0, 0.0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Or",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF202157).withOpacity(0.45),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                      backgroundColor: Colors.white,
                    ),
                    icon: SvgPicture.asset(
                      "assets/icons/google.svg",
                      height: 24,
                      width: 24,
                    ),
                    label: Text(
                      "CONTINUE WITH GMAIL",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF090F47),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateSignupButtonColor() {
    setState(() {
      if (_namaController.text.isNotEmpty &&
          _notelpController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _tanggallahirController.text.isNotEmpty &&
          _selectedGender != null &&
          _alamatController.text.isNotEmpty) {
        _signupButtonColor = const Color(0xFF202157);
      } else {
        _signupButtonColor = Colors.grey;
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggallahirController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
      _updateSignupButtonColor();
    }
  }

  void _signup() async {
    final String username = _emailController.text;
    final String password = _passwordController.text;
    final String tanggalLahir = _tanggallahirController.text;
    final DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(tanggalLahir);
    final String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);

    const String apiUrl = 'http://127.0.0.1:8000/users/';
    const String apiLogin = 'http://127.0.0.1:8000/login';
    String apiCreate = 'http://127.0.0.1:8000/create_profile'; // Modified URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Sign-up successful
        // if signup successful, do login to get the token
        try {
          final respLogin = await http.post(
            Uri.parse(apiLogin),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'username': username,
              'password': password,
            }),
          );

          if (respLogin.statusCode == 200) {
            final Map<String, dynamic> responseBodyLogin = jsonDecode(respLogin.body);
            final String accessToken = responseBodyLogin['access_token'];
            final int userId = responseBodyLogin['user_id'];

            // Modified URL to include userId in the endpoint
            apiCreate = '$apiCreate/$userId';

            // if login successful, make new profile for the new account
            try {
              final responseProfile = await http.post(
                Uri.parse('http://127.0.0.1:8000/create_profile/$userId'),
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $accessToken',
                },
                body: jsonEncode(<String, dynamic>{
                    'userId': userId.toString(), // Add userId field
                    'nama': _namaController.text,
                    'tanggalLahir': formattedDate,
                    'jenisKelamin': _selectedGender!,
                    'alamat': _alamatController.text,
                    'email': _emailController.text,
                    'noTelepon': _notelpController.text,
                    'userPhoto': "dummy.png",
                    'isMainProfile': "1",
                }),
              );

              if (responseProfile.statusCode == 200) {
                print (responseProfile);
              } else {
                throw Exception(response.reasonPhrase);
              }

              if (responseProfile.statusCode == 200) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Sign-up Successful'),
                      content: Text('You have successfully signed up!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())); // Navigate to login page
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                print('Failed to create profile: ${responseProfile.reasonPhrase}');
                print('Response body: ${responseProfile.body}');
              }
            } catch (e) {
              print('Exception during making profile: $e');
            }
          } else {
            print('Failed to login: ${respLogin.reasonPhrase}');
            print('Response body: ${respLogin.body}');
          }
        } catch (e) {
          // Handle exceptions during login
          print('Exception during login: $e');
        }
      } else {
        // Handle sign-up errors
        if (response.body.isNotEmpty) {
          final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Sign-up Error'),
                content: Text(errorResponse['detail'] ?? 'Unknown Error'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle other errors
          print('Failed to sign up: ${response.reasonPhrase}');
          print('Response body: ${response.body}');
        }
      }
    } catch (e) {
      // Handle exceptions during sign-up
      print('Exception during sign-up: $e');
    }
  }
}
