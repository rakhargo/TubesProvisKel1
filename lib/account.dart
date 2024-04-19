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
            'Account',
            style: TextStyle
            (
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 15, 71),
            ),
          ),
        ),
        body: Center
        (
          child: Text
          (
            "Ini Account",
          ),
        ),
      ),
    );
  }
}

