import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:medimate/page/detailDoctor.dart';

import 'package:medimate/provider/api/doctor_api.dart';
import 'package:medimate/provider/api/specialistAndPoliclinic_api.dart';
import 'package:medimate/provider/model/doctor_model.dart';
import 'package:medimate/provider/model/healthFacility_model.dart';
import 'package:medimate/provider/api/healthFacility_api.dart';

class DoctorProfilePage extends StatefulWidget {
  final String responseBody;
  final String profileId;
  final String relasiRsPoliId;
  final String rsId;
  final String poliId;

  const DoctorProfilePage({Key? key, required this.responseBody, required this.profileId, this.relasiRsPoliId = '', this.poliId = '', this.rsId = ''}) : super(key: key);

  @override
  State<DoctorProfilePage> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfilePage> {

  // Doctor doctorDetails = Doctor
  // (
  //   id: "",
  //   nama: "",
  //   spesialisasi: "",
  //   pengalaman: 0,
  //   foto: "",
  // );

  List<Map<String, dynamic>> doctorList = [];

  List<Map<String, dynamic>> relasiDoctorRsPoliList = [];
  
  List<RelasiRsPoli> relasiRsPoli = [];
  RelasiRsPoliDoctor relasiDoctorRsPoli = RelasiRsPoliDoctor(
      doctorId: "",
      relasiRsPoliId: "",
      id: "",
      harga: 0,
    );

  List<Doctor> doctorListPoliId = [];
  late String accessToken;

  @override
  void initState() {
    super.initState();
    _initializeAccessToken();
    // _fetchDoctorByRelasiId(widget.relasiRsPoliId, widget.poliId);
    // fetchDoctorPolyId(widget.poliId);
    // fetchRsPolyId(widget.poliId);
    jalaninAjaDulu(widget.poliId);
  }

  void _initializeAccessToken() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    accessToken = responseBodyMap['access_token'];
  }

  void fetchDoctorPolyId(String poliId) async {
    try {
      doctorListPoliId = await Provider.of<DoctorAPI>(context, listen: false).fetchDataDoctorByPolyId(poliId, accessToken);
      // print(doctorListPoliId);
        // Use the doctorList as needed
    } catch (e) {
      // Handle any exceptions
      print('Error fetching doctor data: $e');
    }
  }

  void fetchRsPolyId(String poliId) async {
    try {
      relasiRsPoli = await Provider.of<HealthFacilityAPI>(context, listen: false).fetchRelasiRsPoliByPoliId(poliId, accessToken);
    } catch (e) {
      print('Error fetching relasiRsPoli : $e');
    }
  }

  void fetchDrRsPoliId(String relasiRsPoliId, String doctor_id) async {
    try {
      relasiDoctorRsPoli = await Provider.of<DoctorAPI>(context, listen: false)
      .fetchRelasiRsPoliDoctorByIdId(relasiRsPoliId, doctor_id, accessToken);
      // relasiDoctorRsPoliList.add(relasiDoctorRsPoli);
      // print("masuk sini woy\n");
    } catch (e) {
      print('Error fetching relasiRsPoli : $e');
    }
  }

  void jalaninAjaDulu(String poliId) async {
    if (widget.relasiRsPoliId == '') {
      doctorListPoliId = await Provider.of<DoctorAPI>(context, listen: false).fetchDataDoctorByPolyId(poliId, accessToken);
      relasiRsPoli = await Provider.of<HealthFacilityAPI>(context, listen: false).fetchRelasiRsPoliByPoliId(poliId, accessToken);
      for (var relasi1 in doctorListPoliId) {
        for (var relasi2 in relasiRsPoli) {
            relasiDoctorRsPoli = await Provider.of<DoctorAPI>(context, listen: false)
          .fetchRelasiRsPoliDoctorByIdId(relasi2.id, relasi1.id, accessToken);
          if (relasiDoctorRsPoli.id != '0') {
            var combinedData = {
              'harga': relasiDoctorRsPoli.harga,
              'doctor': await Provider.of<DoctorAPI>(context, listen: false).fetchDataDoctorById(relasiDoctorRsPoli.doctorId, accessToken),
              'poli': await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false).fetchDataById(widget.poliId, accessToken),
              'healthFacility': await Provider.of<HealthFacilityAPI>(context, listen: false).fetchDataById(relasi2.rsId, accessToken),
            };
            relasiDoctorRsPoliList.add(combinedData);
          }
        }
      }
      setState(() {
        doctorList = relasiDoctorRsPoliList;
        print(inspect(doctorList));
      });
    }
    else {
      final _doctorList = await Provider.of<DoctorAPI>(context, listen: false).fetchDataAllDoctor(accessToken);
      final _poli = await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false).fetchDataById(poliId, accessToken);
      
      List<RelasiRsPoliDoctor> relasiRsPoliDoctorList = await Provider.of<DoctorAPI>(context, listen: false).fetchRelasiRsPoliDoctorByRelasiId(widget.relasiRsPoliId, accessToken);
      List<Map<String, dynamic>> result = [];

      for (var relasi in relasiRsPoliDoctorList) {
        var combinedData = {
          'harga': relasi.harga,
          'doctor': _doctorList.firstWhere((d) => d.id == relasi.doctorId),
          'poli': _poli,
          'id': relasi.id
        };
        result.add(combinedData);
      }
      setState(() {
        doctorList = result;
        print(inspect(doctorList));
      });
    }
  }

  // Future<void> _fetchDoctorByRelasiId(String relasiRsPoliId, String poliId) async {
  //   // List<Map<String, dynamic>> result1 = [];
  //   // List<Map<String, dynamic>> relasiRsPoli = [];
  //   // // if (relasiRsPoliId == '') 
  //   // // {
  //   // //   final _healthFacilityList = await Provider.of<HealthFacilityAPI>(context, listen: false).fetchDataAll(accessToken);
  //   // //   List<RelasiRsPoli> relasiRsPoliList = await Provider.of<HealthFacilityAPI>(context, listen: false).fetchRelasiRsPoliByPoliId(poliId, accessToken);

  //   // //   for (var relasi in relasiRsPoliList) {
  //   // //     var combinedData = {
  //   // //       'healthFacility': _healthFacilityList.firstWhere((hf) => hf.id == relasi.rsId),
  //   // //       'id': relasi.id
  //   // //     };
  //   // //     result1.add(combinedData);
  //   // //   }
  //   // //   setState(() {
  //   // //     relasiRsPoli = result1;
  //   // //   });
  //   // // }
  //   // // else
  //   // // {
  //   //   final _healthFacilityList = await Provider.of<HealthFacilityAPI>(context, listen: false).fetchDataAll(accessToken);
  //   //   List<RelasiRsPoli> relasiRsPoliList = await Provider.of<HealthFacilityAPI>(context, listen: false).fetchRelasiRsPoliByPoliId(poliId, accessToken);

  //   //   for (var relasi in relasiRsPoliList) {
  //   //     var combinedData = {
  //   //       'healthFacility': _healthFacilityList.firstWhere((hf) => hf.id == relasi.rsId),
  //   //       'id': relasi.id
  //   //     };
        
  //   //     result1.add(combinedData);
  //   //   }
  //   //   setState(() {
  //   //     relasiRsPoli = result1;
  //   //   });
  //   // // }

  //   // print("INI INSPECT relasiRsPoli");
  //   // print(inspect(relasiRsPoli));
  //   final _doctorList = await Provider.of<DoctorAPI>(context, listen: false).fetchDataAllDoctor(accessToken);
  //   final _poli = await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false).fetchDataById(poliId, accessToken);
    
  //   // List<RelasiRsPoliDoctor> relasiRsPoliDoctorList = await Provider.of<DoctorAPI>(context, listen: false).fetchAllRelasiRsPoliDoctor(accessToken);
  //   List<RelasiRsPoliDoctor> relasiRsPoliDoctorList = await Provider.of<DoctorAPI>(context, listen: false).fetchRelasiRsPoliDoctorByRelasiId(relasiRsPoliId, accessToken);
  //   List<Map<String, dynamic>> result = [];

  //   for (var relasi in relasiRsPoliDoctorList) {
  //       // print("INI RELASI DI FOR");
  //       // print(relasi);
  //     var combinedData = {
  //       // 'healthFacilityId': relasiRsPoli,
  //       'doctor': _doctorList.firstWhere((d) => d.id == relasi.doctorId),
  //       // 'rsId': relasi.rsId,
  //       // 'poli': _poli,
  //       'poli': _poli,
  //       // 'poliId': widget.poliId,
  //       'id': relasi.id
  //     };
  //     print("ABIS BIKIN COMBINED");
  //     result.add(combinedData);
  //   }
  //   // print("INI LIST JOIN");
  //   //   print(result);
  //   setState(() {
  //     doctorList = result;
  //     print("INI INSPECT DOCTOR");
  //     print(inspect(doctorList));
  //     // print(specialistAndPolyclinicListResponse);
  //   });
  // }

  

  @override
  Widget build(BuildContext context) {
    // fetchDoctorPolyId(widget.poliId);
    // fetchRsPolyId(widget.poliId);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Doctors',
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
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          
          child: ListView.builder(
            itemCount: doctorList.length,
            itemBuilder: (context, index) {
              var item = doctorList[index];
              print(inspect(item));
              return Column(
                children: [
                  Row(
                    children: [
                      Image(image: AssetImage("assets/images/orang/dokter/${item['doctor'].foto}")),
                      
                      Expanded
                      (
                        child: Container
                        (
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['doctor'].nama,
                                style: const TextStyle(
                                  color: Color(0xFF090F47),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                // "Spesialisasi",
                                item['poli'].name,
                                style: const TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 85, // Adjust width as needed
                                    height: 30, // Adjust height as needed
                                    decoration: BoxDecoration(
                                      color: Color(0x80E7E7E7),
                                      borderRadius: BorderRadius.circular(8), // Adjust border radius as needed
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.medical_services_outlined,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          item['doctor'].pengalaman.toString(),
                                          style: const TextStyle(
                                            color: Color(0xFF090F47),
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(width: 5), // Add some spacing between the text elements
                                        Text(
                                          'Year',
                                          style: const TextStyle(
                                            color: Color(0xFF090F47),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10), // Add some spacing between the containers

                                  // Container(
                                  //   width: 65, // Adjust width as needed
                                  //   height: 30, // Adjust height as needed
                                  //   decoration: BoxDecoration(
                                  //     color: Color(0x80E7E7E7),
                                  //     borderRadius: BorderRadius.circular(8
                                  //     ), // Adjust border radius as needed

                                  //   ),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.center,
                                  //     children: [
                                  //       Icon(
                                  //         Icons.star,
                                  //         color : Color(0xFFFFC90A)
                                  //       ), // You can replace this with your desired icon
                                  //       SizedBox(width: 5), // Add some spacing between the icon and text
                                  //       Text(
                                  //         item["rating"], // Replace with your rating value
                                  //         style: const TextStyle(
                                  //           color: Color(0xFF090F47),
                                  //           fontSize: 15,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),                
                                ],
                              ),
                              widget.relasiRsPoliId == '' ?
                              Text(
                                // item["schedule"],
                                // "Health Facility(?)",
                                item['healthFacility'].namaFasilitas,
                                // item['healthFacility']['healthFacility'].namaFasilitas,
                                style: const TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 12,
                                ),
                              )
                              :
                              
                              // Text(
                              //   // item["schedule"],
                              //   // "Health Facility(?)",
                              //   "Schedule (?)",
                              //   // item['healthFacility']['healthFacility'].namaFasilitas,
                              //   style: const TextStyle(
                              //     color: Color(0xFF828282),
                              //     fontSize: 12,
                              //   ),
                              // ),
                              const SizedBox(height: 3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(item["harga"]),
                                      // "Harga (?)",
                                      style: const TextStyle(
                                        color: Color(0xFF3E3E3E),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  GestureDetector
                                  (
                                    onTap: () 
                                    {
                                      // Navigator.push
                                      // (
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => DetailDoctorPage()),
                                      // );
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) 
                                      {
                                        return (widget.relasiRsPoliId == '')
                                        ? (DetailDoctorPage(responseBody: widget.responseBody, profileId: widget.profileId, healthFacilityId: item['healthFacility'].id, doctorId: item['doctor'].id, poliId: widget.poliId, harga: item["harga"]))
                                        : (DetailDoctorPage(responseBody: widget.responseBody, profileId: widget.profileId, healthFacilityId: widget.rsId, doctorId: item['doctor'].id, poliId: widget.poliId, harga: item["harga"]));
                                      }
                                      ));
                                    },
                                    child: Container(
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF0F1035),
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Book',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container
                  (
                    decoration: const BoxDecoration
                      (
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1),
                        ),
                      ),
                  )
                  // const SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
