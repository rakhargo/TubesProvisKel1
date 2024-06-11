import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medimate/page/Screens/Signup/signup_screen.dart';
import 'package:medimate/main.dart';
import 'package:flutter/gestures.dart';

import 'package:medimate/provider/api/profile_api.dart';
import 'package:medimate/provider/model/profile_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Color _loginButtonColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              onChanged: (_) => _updateLoginButtonColor(),
              decoration: InputDecoration(
                hintText: "Enter your email",
                hintStyle:
                    TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF202157)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              onChanged: (_) => _updateLoginButtonColor(),
              decoration: InputDecoration(
                hintText: "Enter your password",
                hintStyle:
                    TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: const Color(0xFF090F47).withOpacity(0.45),
                    size: 24,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF202157)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xFF202157).withOpacity(0.45)),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loginButtonColor == Colors.grey ? null : _login,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                backgroundColor: _loginButtonColor,
              ),
              child: Text(
                "LOG IN",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(color: Color(0xFF202157).withOpacity(0.45)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateLoginButtonColor() {
    setState(() {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        _loginButtonColor = Color(0xFF202157);
      } else {
        _loginButtonColor = Colors.grey;
      }
    });
  }

  void _login() async {
    final username = _emailController.text;
    final password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      print('Login response: ${response.statusCode}');
      print('Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        final responseBodyMap = jsonDecode(responseBody);
        final userId = responseBodyMap['user_id'].toString();
        final accessToken = responseBodyMap['access_token'].toString();

        final responseBaru = await http.get(
          Uri.parse('http://127.0.0.1:8000/profile_user_id/$userId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        );
        final responseBaruBodyMap = jsonDecode(responseBaru.body);
        // print(responseBaruBodyMap);

        final mainProfile = responseBaruBodyMap
            .firstWhere((profile) => profile['isMainProfile'] == 1);
        // print(mainProfile);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainApp(
                    responseBody: responseBody,
                    indexNavbar: 0,
                    profileId: mainProfile['id'].toString(),
                  )),
        );
      } else {
        if (response.body.isNotEmpty) {
          final errorResponse =
              jsonDecode(response.body) as Map<String, dynamic>;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Login Error'),
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
          print('Failed to log in: ${response.reasonPhrase}');
          print('Response body: ${response.body}');
        }
      }
    } catch (e) {
      print('Exception during login: $e');
    }
  }
}
