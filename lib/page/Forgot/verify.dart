import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController _otpController = TextEditingController(); // Ganti nama controller menjadi _otpController
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
                      "Verify Your Email",
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
                  "images/forgot/2.png",
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
                      "Please Enter the 4 Digit Code Sent\nto Johndoe@gmail.com",
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
                        controller: _otpController, // Menggunakan _otpController
                        onChanged: (_) => _updateLoginButtonColor(),
                        keyboardType: TextInputType.number, // Mengatur keyboard type menjadi number
                        decoration: InputDecoration(
                          hintText: "Enter OTP", // Mengubah hintText
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
                          "VERIFY",
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
          _otpController.text.length == 4 ? Color(0xFF202157) : Colors.grey; // Mengubah logika validasi
    });
  }

  void _sendEmail() {
    // Implement sending email logic here
    print("Verifying OTP: ${_otpController.text}");
    // Anda dapat menambahkan logika verifikasi OTP di sini
  }
}
