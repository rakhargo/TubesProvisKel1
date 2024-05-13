import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Utama/activity.dart';

class BookingSummaryPage extends StatefulWidget {
  final Map<dynamic, dynamic> bookingDetails;
  const BookingSummaryPage({Key? key, required this.bookingDetails}) : super(key: key);

  @override
  State<BookingSummaryPage> createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummaryPage>
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        leading: IconButton
        (
          icon: const Icon
          (
            Icons.arrow_back_ios, 
            color: Color.fromARGB(255, 54, 84, 134),
          ),
          onPressed: () {
            Navigator.pop(context); // Kembali ke layar sebelumnya
          },
        ),
        title: const Text
        (
          'Booking',
          style: TextStyle
          (
            fontWeight: FontWeight.bold,
            color: Color(0xFF091547),
          ),
        ),
      ),
      body: SingleChildScrollView
      (
        child: Center
        (
          child: Padding
          (
            padding: const EdgeInsets.all(15.0),
            child: Container
            (
              height: 500,
              decoration: BoxDecoration
              (
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 235, 235, 255),
              ),
              child: Column
              (
                children: 
                [
                  const Text
                  (
                    'Booking Summary',
                    style: TextStyle
                    (
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF091547),
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding
                  (
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row
                    (
                      children: 
                      [
                        Column
                        (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: 
                          [
                            const Text
                            (
                              "Doctor Name", 
                              style: TextStyle
                              (
                                color: Color.fromARGB(204, 32, 33, 87),
                              )
                            ),
                            Text
                            (
                              widget.bookingDetails['doctorName'], 
                              style: const TextStyle
                              (
                                color: Color.fromARGB(204, 32, 33, 87),
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ],
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                  Padding
                  (
                    padding: const EdgeInsets.all(8.0),
                    child: Container // garis abu
                    (
                      decoration: const BoxDecoration
                      (
                        border: Border
                        (
                          bottom: BorderSide(color: Color.fromARGB(128, 32, 33, 87), width: 2),
                        ),
                      ),
                    ),
                  ),

                  Padding
                  (
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row
                    (
                      children: 
                      [
                        Column
                        (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: 
                          [
                            const Text
                            (
                              "Specialist", 
                              style: TextStyle
                              (
                                color: Color.fromARGB(204, 32, 33, 87),
                              )
                            ),
                            Text
                            (
                              widget.bookingDetails['specialist'], 
                              style: const TextStyle
                              (
                                color: Color.fromARGB(204, 32, 33, 87),
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ],
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                  Padding
                  (
                    padding: const EdgeInsets.all(8.0),
                    child: Container // garis abu
                    (
                      decoration: const BoxDecoration
                      (
                        border: Border
                        (
                          bottom: BorderSide(color: Color.fromARGB(128, 32, 33, 87), width: 2),
                        ),
                      ),
                    ),
                  ),

                  Padding
                  (
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row
                    (
                      children: 
                      [
                        Column
                        (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: 
                          [
                            const Text
                            (
                              "Hospital", 
                              style: TextStyle
                              (
                                color: Color.fromARGB(204, 32, 33, 87),
                              )
                            ),
                            Text
                            (
                              widget.bookingDetails['hospital'], 
                              style: const TextStyle
                              (
                                color: Color.fromARGB(204, 32, 33, 87),
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ],
                        ),
                        const Spacer()
                      ],
                    ),
                  ),

                  Padding
                  (
                    padding: const EdgeInsets.all(8.0),
                    child: Container // garis abu
                    (
                      decoration: const BoxDecoration
                      (
                        border: Border
                        (
                          bottom: BorderSide(color: Color.fromARGB(128, 32, 33, 87), width: 2),
                        ),
                      ),
                    ),
                  ),

                  Padding
                  (
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row
                    (
                      children: 
                      [
                        Column
                        (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: 
                          [
                            const Text
                            (
                              "Price", 
                              style: TextStyle
                              (
                                color: Color.fromARGB(204, 32, 33, 87),
                              )
                            ),
                            Text
                            (
                              widget.bookingDetails['price'], 
                              style: const TextStyle
                              (
                                color: Color.fromARGB(204, 32, 33, 87),
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ],
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                  Padding
                  (
                    padding: const EdgeInsets.all(8.0),
                    child: Container // garis abu
                    (
                      decoration: const BoxDecoration
                      (
                        border: Border
                        (
                          bottom: BorderSide(color: Color.fromARGB(128, 32, 33, 87), width: 2),
                        ),
                      ),
                    ),
                  ),

                  Padding
                  (
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row
                    (
                      children: 
                      [
                        Column
                        (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: 
                          [
                            const Text
                            (
                              "Date & Time", 
                              style: TextStyle
                              (
                                color: Color.fromARGB(204, 32, 33, 87),
                              )
                            ),
                            Text
                            (
                              widget.bookingDetails['dateTime'], 
                              style: const TextStyle
                              (
                                color: Color.fromARGB(204, 32, 33, 87),
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ],
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                  Padding
                  (
                    padding: const EdgeInsets.all(8.0),
                    child: Container // garis abu
                    (
                      decoration: const BoxDecoration
                      (
                        border: Border
                        (
                          bottom: BorderSide(color: Color.fromARGB(128, 32, 33, 87), width: 2),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  GestureDetector
                  (
                    onTap: () 
                  {
                    Navigator.push
                    (
                      context,
                      MaterialPageRoute(builder: (context) => ActivityPage()),
                    );
                  },
                    child: Container
                    (
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration
                      (
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 32, 33, 87),
                      ),
                      child: const Center
                      (
                        child: Text
                        (
                          'CONFIRM',
                          style: TextStyle
                          (
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  GestureDetector
                  (
                    onTap: () {
                      Navigator.pop(context); // Kembali ke layar sebelumnya
                    },
                    child: Container
                    (
                      padding: const EdgeInsets.all(8),
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration
                      (
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 200, 52, 52),
                      ),
                      child: const Center
                      (
                        child: Text
                        (
                          'CANCEL',
                          style: TextStyle
                          (
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  )
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}