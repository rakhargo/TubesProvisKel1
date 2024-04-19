import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() 
{
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage>
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      home: Scaffold
      (
        appBar: AppBar
        (
          title: const Text
          (
            'Home',
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
            "Ini home",
          ),
        ),
      ),
    );
  }
}

