import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:medimate/main.dart';
import 'package:medimate/page/Account/orders.dart';
import 'package:medimate/page/medicalRecord.dart';
import 'package:medimate/page/Account/orders.dart';
import 'package:provider/provider.dart';
import 'package:medimate/bottomNavBar.dart';

import 'package:medimate/provider/api/appointment_api.dart';
import 'package:medimate/provider/model/appointment_model.dart';

import 'package:medimate/provider/api/specialistAndPoliclinic_api.dart';
import 'package:medimate/provider/model/specialistAndPolyclinic_model.dart';

import 'package:medimate/provider/api/doctor_api.dart';
import 'package:medimate/provider/model/doctor_model.dart';

import 'package:medimate/provider/api/healthFacility_api.dart';
import 'package:medimate/provider/model/healthFacility_model.dart';

import 'dart:developer';

import 'package:intl/date_symbol_data_local.dart';

class ActivityPage extends StatefulWidget {
  final String responseBody;
  final String profileId;

  const ActivityPage({Key? key, required this.responseBody, required this.profileId}) : super(key: key);
  
  @override
  State<ActivityPage> createState() => _ActivityState();
}

class _ActivityState extends State<ActivityPage>
{
  List<Map<String, dynamic>> appointmentList = [];

  List<Map<String, dynamic>> onGoingList = [];
  List<Map<String, dynamic>> recentList = [];
  List<Map<String, dynamic>> recentListTop3 = [];

  late String accessToken;
  late String userId;

  @override
  void initState() {
    super.initState();
    // _initializeLocale();
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
      // print("SEBELUM PROSES JOIN");
      for (var relasi in _appointmentList) {
        // print("RELASI-JOIN-FOR");
        var combinedData = {
          'doctor': _doctorList.firstWhere((d) => d.id == relasi.doctorId),
          'judulPoli': _judulPoliList.firstWhere((jp) => jp.id == relasi.relasiJudulPoliId),
          'faskes': _faskesList.firstWhere((f) => f.id == relasi.facilityId),
          // 'rsId': relasi.rsId,
          // 'poliId': relasi.poliId,
          'antrian': relasi.antrian,
          'metodePembayaran': relasi.metodePembayaran,
          'waktu': relasi.waktu,
          'patientId': relasi.patientId,
          'status': relasi.status,
          'id': relasi.id,
        };
        // print("ABIS BIKIN COMBINED");
        result.add(combinedData);
      }
      // print("INI LIST JOIN");
      //   print(result);
      setState(() {
        appointmentList = result;
        print("INI INSPECT appointment");
        print(inspect(appointmentList));
        // print(specialistAndPolyclinicListResponse);
        for (var appointment in appointmentList) 
        {
          if (appointment['status'] == "recent") {
            recentList.add(appointment);
          } else if (appointment['status'] == "ongoing") {
            onGoingList.add(appointment);
          }
        }
        
        recentListTop3 = recentList;
        if (recentList.length > 3) {
          recentListTop3 = recentList.reversed.toList().sublist(0, 3).reversed.toList();
        }
        // print(inspect(onGoingList));
        // print(onGoingList.length);

        // print(inspect(recentList));
        // print(recentList.length);
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
      return Scaffold
      (
        appBar: AppBar
        (
          title: const Text
          (
            'Activity',
            style: TextStyle
            (
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 15, 71),
            ),
          ),
          bottom: PreferredSize
          (
            preferredSize: const Size.fromHeight(2.0), //Set the height of the border
            child: Container
            (
              decoration: const BoxDecoration
              (
                border: Border
                (
                  bottom: BorderSide
                  (
                    color: Colors.grey, // Set the color of the border
                    width: 0.5, // Set the width of the border
                  ),
                ),
                boxShadow: 
                [
                  BoxShadow
                  (
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
          child: Padding
          (
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                const Padding
                (
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Text
                  (
                    "Ongoing",
                    textAlign: TextAlign.left,
                    style: TextStyle
                    (
                      color: Color.fromARGB(255, 9, 15, 71),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0
                    ),
                  ),
                ),
                const SizedBox
                (
                  height: 10,
                ),
                onGoingList.isEmpty ? 
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
                  // height: appointmentList.length * 150 + 80,
                  height: onGoingList.length * 160 + 50,
                  child: ListView.builder
                  (
                    physics: NeverScrollableScrollPhysics(),
                    // itemCount: appointmentList.length,
                    itemCount: onGoingList.length,
                    itemBuilder: (context, index)
                    {
                      // var item = appointmentList[index];
                      var item = onGoingList[index];
                      // judulPoli =
                      // await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false)
                      //       .fetchJudulPoliById(item.relasiJudulPoliId, accessToken);
                      // print("INI ITEM");
                      // print(item);
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
                                      Expanded
                                      (
                                        child: Text
                                        (
                                          // item["title"],
                                          item['judulPoli'].judul,
                                          style: const TextStyle
                                          (
                                            color: Color.fromARGB(255, 32, 33, 87),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Column
                                      (
                                        children: 
                                        [
                                          Text
                                          (
                                            // item["lokasi"],
                                            "Antrian",
                                            style: const TextStyle
                                            (
                                              color: Color.fromARGB(216, 53, 55, 121),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text
                                          (
                                            "${item['antrian'].toString()}",
                                            style: const TextStyle
                                            (
                                              color: Color.fromARGB(216, 53, 55, 121),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
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
                                  // item.doctorId,
                                  item['doctor'].nama,
                                  style: const TextStyle
                                  (
                                    color: Color.fromARGB(216, 53, 55, 121),
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                // Text
                                // (
                                //   // item["lokasi"],
                                //   "bojongsoang",
                                //   style: const TextStyle
                                //   (
                                //     color: Color.fromARGB(216, 53, 55, 121),
                                //     fontSize: 12,
                                //   ),
                                // ),
                                // const SizedBox(height: 3),
                                Text
                                (
                                  item['faskes'].namaFasilitas,
                                  // item["rs"],
                                  style: const TextStyle
                                  (
                                    color: Color.fromARGB(216, 53, 55, 121),
                                    fontSize: 12,
                                  ),
                                ),
                                Center
                                (
                                  child: Padding
                                  (
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                    child: LayoutBuilder
                                    (
                                      builder: (context, constraints) 
                                      {
                                        final boxWidth = constraints.maxWidth;
                                        return GestureDetector
                                        (
                                          onTap: () async
                                          {
                                            await Provider.of<AppointmentAPI>(context, listen: false).updateAppointment
                                            (
                                              item,
                                              accessToken,
                                            );

                                            Map<String, dynamic> medRec = 
                                            {
                                              "patientId": int.parse(widget.profileId),
                                              "date": item['waktu'],
                                              "appointmentId": int.parse(item['id']),
                                              "relasiJudulPoliId": int.parse(item['judulPoli'].id),
                                            };

                                            await Provider.of<AppointmentAPI>(context, listen: false).addMedicalRecord
                                            (
                                              medRec,
                                              accessToken,
                                            );
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) => MainApp(responseBody: widget.responseBody, indexNavbar: 2, profileId: widget.profileId,),
                                                
                                              ),
                                            );
                                          },
                                          child: Container
                                          (
                                            width: boxWidth / 2, // set the width to half of the parent container
                                            decoration: BoxDecoration
                                            (
                                              color: const Color.fromARGB(204, 53, 55, 121),
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
                                                  Icons.pin_drop_outlined,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),
                                                SizedBox(width: 6.0),
                                                Text
                                                (
                                                  // 'View on maps',
                                                  'Done',
                                                  style: TextStyle
                                                  (
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  )
                ),
                Row
                (
                  children: 
                  [
                    const Padding
                    (
                      padding: EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Text
                      (
                        "Recent",
                        textAlign: TextAlign.left,
                        style: TextStyle
                        (
                          color: Color.fromARGB(255, 9, 15, 71),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton
                    (
                      style: TextButton.styleFrom
                      (
                        foregroundColor: const Color.fromARGB(255, 9, 15, 71),
                      ),
                      onPressed: ()
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) 
                        {
                          return (MyOrdersPage(responseBody: widget.responseBody, profileId: widget.profileId));
                        }
                        ));
                      }, // ke laman see more
                      child: const Text("See More"),
                    )
                  ],
                ),
                const SizedBox
                (
                  height: 10,
                ),
                recentListTop3.isEmpty ? 
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
                  height: recentListTop3.length * 130 + 50,
                  child: Builder
                  (
                    builder: (context) 
                    {
                      return ListView.builder
                      (
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: recentListTop3.length,
                        itemBuilder: (context, index)
                        {
                          var item = recentListTop3[index];
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
      );
  }
}
