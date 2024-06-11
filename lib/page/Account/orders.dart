import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:medimate/page/medicalRecord.dart';

import 'package:medimate/provider/api/appointment_api.dart';
import 'package:medimate/provider/model/appointment_model.dart';

import 'package:medimate/provider/api/specialistAndPoliclinic_api.dart';
import 'package:medimate/provider/model/specialistAndPolyclinic_model.dart';

import 'package:medimate/provider/api/doctor_api.dart';
import 'package:medimate/provider/model/doctor_model.dart';

import 'package:medimate/provider/api/healthFacility_api.dart';
import 'package:medimate/provider/model/healthFacility_model.dart';

class MyOrdersPage extends StatefulWidget {
  final String responseBody;
  final String profileId;

  const MyOrdersPage({Key? key, required this.responseBody, required this.profileId}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrdersPage>
{
  List<Map<String, dynamic>> appointmentList = [];

  // List<Map<String, dynamic>> onGoingList = [];
  List<Map<String, dynamic>> recentList = [];

  late String accessToken;
  late String userId;

  @override
  void initState() {
    super.initState();
    _initializeUserId();
    _initializeAccessToken();
    _fetchDataAllAppointment();
  }

  // Future<void>_initializeLocale() async {
  //   await initializeDateFormatting('id_ID', '');
  // }

  void _initializeUserId() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    userId = responseBodyMap['user_id'].toString();
  }

  void _initializeAccessToken() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    accessToken = responseBodyMap['access_token'];
  }

  Future<void> _fetchDataAllAppointment() async {
    try {
      final _doctorList = await Provider.of<DoctorAPI>(context, listen: false).fetchDataAllDoctor(accessToken);
      final _judulPoliList = await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false).fetchAllJudulPoli(accessToken);
      final _faskesList = await Provider.of<HealthFacilityAPI>(context, listen: false).fetchDataAll(accessToken);
      List<Appointment> _appointmentList = await Provider.of<AppointmentAPI>(context, listen: false).fetchDataAll(widget.profileId, accessToken);
      List<Map<String, dynamic>> result = [];
      for (var relasi in _appointmentList) {
        var combinedData = {
          'doctor': _doctorList.firstWhere((d) => d.id == relasi.doctorId),
          'judulPoli': _judulPoliList.firstWhere((jp) => jp.id == relasi.relasiJudulPoliId),
          'faskes': _faskesList.firstWhere((f) => f.id == relasi.facilityId),
          'antrian': relasi.antrian,
          'metodePembayaran': relasi.metodePembayaran,
          'waktu': relasi.waktu,
          'patientId': relasi.patientId,
          'status': relasi.status,
          'id': relasi.id,
        };
        result.add(combinedData);
      }
      setState(() {
        appointmentList = result;
        for (var appointment in appointmentList) 
        {
          if (appointment['status'] == "recent") {
            recentList.add(appointment);
          }
        }
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  String formatDateHour(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return DateFormat('d MMMM y, HH:mm').format(dateTime);
  }

  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return DateFormat('d MMMM, y').format(dateTime);
  }

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Account Page',
      home: Scaffold
      (
        appBar: AppBar(
          title: const Text(
            'My Orders',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 15, 71),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Color(0xFF202157),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0), //Set the height of the border
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Set the color of the border
                    width: 0.5, // Set the width of the border
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, // Set the color of the shadow
                    blurRadius: 2.0, // Set the blur radius of the shadow
                    offset: Offset(0.0, 2.0), // Set the offset of the shadow
                  ),
                ],
              ),
            ),
          ),
        ),

        body: SingleChildScrollView
        (
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Record',
                      hintStyle: const TextStyle(
                        color: Color(0x99353779),
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF202157),
                        size: 24,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xff353779),
                          width: 3.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(top: 0),
                    ),
                  ),
          
                  // const SizedBox(height: 20),
          
                  // SingleChildScrollView
                  // (
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row
                  //   (
                  //     children: topics
                  //         .map((topic) => Padding
                  //         (
                  //           padding: const EdgeInsets.only(right: 20),
                  //           child: ChoiceChip
                  //           (
                  //             showCheckmark: false,
                  //             label: Text
                  //             (
                  //               topic,
                  //               style: TextStyle
                  //               (
                  //                 color: topic == selectedTopic
                  //                     ? Colors.white
                  //                     : const Color.fromARGB(255, 53, 55, 121),
                  //               ),
                  //             ),
                  //             shape: RoundedRectangleBorder
                  //             (
                  //               borderRadius: BorderRadius.circular(13),
                  //               // side: BorderSide.none
                  //             ),
                  //             selected: topic == selectedTopic, // Ubah ini untuk membuat selected sesuai dengan kondisi Anda
                  //             selectedColor: const Color.fromARGB(255, 53, 55, 121),
                  //             backgroundColor: const Color.fromARGB(255, 235, 235, 255),
                  //             onSelected: (selected) 
                  //             {
                  //               // Tambahkan fungsi untuk menangani pemilihan chip
                  //               setState(() {
                  //                 selectedTopic = selected ? topic : "All";
                  //               });
          
                  //               if (selected) 
                  //               {
                  //                 // Lakukan sesuatu ketika chip dipilih
                  //               }
                  //             },
                  //           ),
                  //         ))
                  //         .toList(),
                  //   ),
                  // ),
                  
                  const SizedBox(height: 20),
                  recentList.isEmpty ? 
                  const Center
                  (
                    child: Text
                    (
                      "No record",
                      // textAlign: TextAlign.left,
                      style: TextStyle
                      (
                        color: Color.fromARGB(255, 9, 15, 71),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0
                      ),
                    ),
                  )
                  :
                  SizedBox
                  ( 
                    height: recentList.length * 130 + 50,
                    child: Builder
                    (
                      builder: (context) 
                      {
                        return ListView.builder
                        (
                          scrollDirection: Axis.vertical,
                          itemCount: recentList.length,
                          itemBuilder: (context, index)
                          {
                            var item = recentList[index];
                            return Column
                            (
                              children: 
                              [
                                Container
                                (
                                  // height: 100,
                                  decoration: BoxDecoration
                                  (
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color.fromARGB(255, 113, 115, 189), width: 1.1),
                                  ),
                                  padding: const EdgeInsets.only(left: 14, right: 14, top: 3.4, bottom: 3.4),
                                  child: Column
                                  (
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: 
                                    [
                                      Padding
                                      (
                                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                        child: Row
                                        (
                                          children: 
                                          [
                                            Text
                                            (
                                              // item["title"],
                                              item['judulPoli'].judul,
                                              style: const TextStyle
                                              (
                                                color: Color.fromARGB(255, 32, 33, 87),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const Spacer(),
                                            const Icon
                                            (
                                              Icons.more_vert,
                                              color: Color.fromARGB(165, 32, 33, 87),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text
                                      (
                                        formatDateTime(item['waktu']),
                                        style: const TextStyle
                                        (
                                          color: Color.fromARGB(216, 53, 55, 121),
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text
                                      (
                                        // item["rs"],
                                        item['faskes'].namaFasilitas,
                                        style: const TextStyle
                                        (
                                          color: Color.fromARGB(255, 53, 55, 121),
                                          fontSize: 12,
                                        ),
                                      ),
                                      GestureDetector
                                      (
                                        onTap: ()
                                        {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) 
                                          {
                                            return (MedicalRecordPage(responseBody: widget.responseBody, profileId: widget.profileId, appointmentId: item['id'], relasiJudulPoliId: item['judulPoli'].id));
                                          }
                                          ));
                                        },
                                        child: Center
                                        (
                                          child: Padding
                                          (
                                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                            child: LayoutBuilder
                                            (
                                              builder: (context, constraints) 
                                              {
                                                final boxWidth = constraints.maxWidth;
                                                return Container
                                                (
                                                  width: boxWidth / 2,
                                                  decoration: BoxDecoration
                                                  (
                                                    color: const Color.fromARGB(255, 53, 55, 121),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                                                  child: const Row
                                                  (
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: 
                                                    [
                                                      Icon
                                                      (
                                                        Icons.visibility_outlined,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                      SizedBox(width: 6.0),
                                                      Text
                                                      (
                                                        'View Report',
                                                        style: TextStyle
                                                        (
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          },
                        );
                      },
                    )
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}