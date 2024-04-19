import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() 
{
  runApp(const BookingPage());
}

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingState();
}

class _BookingState extends State<BookingPage>
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Booking Page',
      home: Scaffold
      (
        appBar: AppBar
        (
          title: const Text
          (
            'Booking',
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
            "Ini Booking",
          ),
        ),
      ),
    );
  }
}

