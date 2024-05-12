import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medimate/page/Screens/Signup/signup_screen.dart';
import 'package:medimate/main.dart';
import 'package:flutter/gestures.dart';

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
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 60,
              left: 25,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                ),
              ),
            ),
            Positioned(
              top: 105,
              left: 34,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Welcome back!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color(0xFF090F47),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: size.width * 0.8,
                    child: TextField(
                      controller: _emailController,
                      onChanged: (_) => _updateLoginButtonColor(),
                      decoration: InputDecoration(
                        hintText: "Enter your email",
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
                      onChanged: (_) => _updateLoginButtonColor(),
                      decoration: InputDecoration(
                        hintText: "Enter your password",
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
                  SizedBox(height: 17),
                ],
              ),
            ),
            Positioned(
              top: 305,
              left: 160,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF202157).withOpacity(0.45),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 500,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: _loginButtonColor == Colors.grey ? null : _login,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60), 
                      backgroundColor: _loginButtonColor,
                    ),
                    child: Text(
                      "LOG IN",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 580,
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF202157).withOpacity(0.45),
                  ),
                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF202157).withOpacity(0.45),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500), 
                              pageBuilder: (_, __, ___) => SignUpScreen(), 
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
            Positioned(
              top: 690,
              width: size.width,
              child: Center(
                child: Text(
                  "Or",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF202157).withOpacity(0.45),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 720,
              width: size.width,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      SizedBox(
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateLoginButtonColor() {
    setState(() {
      if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
        _loginButtonColor = Color(0xFF202157);
      } else {
        _loginButtonColor = Colors.grey;
      }
    });
  }

  void _login() {
    if (_emailController.text.trim() == 'admin@gmail.com' &&
        _passwordController.text.trim() == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainApp()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid email or password. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
