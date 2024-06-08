import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medimate/page/Screens/Signup/signup_screen.dart';
import 'package:medimate/main.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController _emailController = TextEditingController();
  Color _loginButtonColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                      "Forgot Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Color(0xFF090F47),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: size.height * 0.2,
                left: 120,
                child: Image.asset(
                  "images/forgot/1.png",
                  width: 200,
                  height: 200,
                ),
              ),
              Positioned(
                top: size.height * 0.42,
                left: 34,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      "Please Enter Your Email Address to\nReceive Verification Code",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xFF202157),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: size.width * 0.8,
                      child: TextField(
                        controller: _emailController,
                        onChanged: (_) => _updateLoginButtonColor(),
                        decoration: InputDecoration(
                          hintText: "Enter Your Email",
                          hintStyle: TextStyle(
                            color: Color(0xFF202157).withOpacity(0.45),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF202157)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF202157).withOpacity(0.45),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 210),
                    Container(
                      width: size.width * 0.8,
                      child: ElevatedButton(
                        onPressed: _loginButtonColor == Colors.grey
                            ? null
                            : _sendEmail,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60),
                          backgroundColor: _loginButtonColor,
                        ),
                        child: Text(
                          "SEND",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Tambahkan spasi di bawah tombol
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateLoginButtonColor() {
    setState(() {
      _loginButtonColor =
          _emailController.text.isNotEmpty ? Color(0xFF202157) : Colors.grey;
    });
  }

  void _sendEmail() {
    // Implement sending email logic here
    print("Sending email to: ${_emailController.text}");
    // You can add your logic to send the email here
  }
}
