import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:medimate/main.dart';
import 'Utama/activity.dart';
import 'Utama/booking.dart';

import 'package:medimate/provider/api/appointment_api.dart';
import 'package:medimate/provider/model/appointment_model.dart';

class BookingSummaryPage extends StatefulWidget {
  final Map<dynamic, dynamic> bookingDetails;
  final String responseBody;
  final String profileId;

  const BookingSummaryPage({Key? key, required this.bookingDetails, required this.responseBody, required this.profileId}) : super(key: key);

  @override
  State<BookingSummaryPage> createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummaryPage>
{
  Appointment appointment = Appointment
  (
    id: "",
    patientId: "",
    doctorId: "",
    facilityId: "",
    status: "",
    waktu: "",
    formattedTime: "",
    metodePembayaran: "",
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
                    onTap: () async{
                      // Dapatkan waktu saat ini dan format menjadi string
                      DateTime now = DateTime.now();
                      final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ'); // Sesuaikan format sesuai kebutuhan
                      String formattedTime = formatter.format(now);

                      await Provider.of<AppointmentAPI>(context, listen: false)
                                    .addAppointment(widget.bookingDetails['patientId'], widget.bookingDetails['doctorId'], widget.bookingDetails['healthFacilityId'], "ongoing", formattedTime, "BCA", 'Bearer $accessToken');
                      Navigator.push(
                        context,
                        MaterialPageRoute
                        (
                          builder: (context) 
                          {
                            return MainApp(responseBody: widget.responseBody, indexNavbar: 2, profileId: widget.profileId,);
                          }
                        ),
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