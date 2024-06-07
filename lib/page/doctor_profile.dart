import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:medimate/page/detailDoctor.dart';

import 'package:medimate/provider/api/doctor_api.dart';
import 'package:medimate/provider/model/doctor_model.dart';

class DoctorProfilePage extends StatefulWidget {
  final String responseBody;
  final String profileId;
  final String relasiRsPoliId;

  const DoctorProfilePage({Key? key, required this.responseBody, required this.profileId, required this.relasiRsPoliId}) : super(key: key);

  @override
  State<DoctorProfilePage> createState() => _DoctorProfileState();
}

// List<Map<dynamic, dynamic>> doctorsData = [
//   {
//     "name": "Dr. Sisca Amartha, Sp. J.P.",
//     "category": "Cardiologist",
//     "exp": "5",
//     "rating": "4.9",
//     "schedule": "Next Schedule : Monday 08:00 - 09:00",
//     "price": "Rp 200.000",
//     "image": "assets/images/orang/dokter/dr_sisca.png" // Add image asset path here
//   },
//   {
//     "name": "Dr. Saeful Baskori, Sp. J.P.",
//     "category": "Cardiologist",
//     "exp": "5",
//     "rating": "4.9",
//     "schedule": "Next Schedule : Monday 08:00 - 09:00",
//     "price": "Rp 200.000",
//     "image": "assets/images/orang/dokter/dr_saeful.png" // Add image asset path here
//   },
//   {
//     "name": "Dr. Rizky Pratama, Sp. J.P.",
//     "category": "Cardiologist",
//     "exp": "5",
//     "rating": "4.9",
//     "schedule": "Next Schedule : Monday 08:00 - 09:00",
//     "price": "Rp 200.000",
//     "image": "assets/images/orang/dokter/dr_rizky.png" // Add image asset path here
//   },
//   {
//     "name": "Dr. Syahid Alamsyah, Sp. J.P.",
//     "category": "Cardiologist",
//     "exp": "5",
//     "rating": "4.9",
//     "schedule": "Next Schedule : Monday 08:00 - 09:00",
//     "price": "Rp 200.000",
//     "image": "assets/images/orang/dokter/dr_alamsyah.png" // Add image asset path here
//   },
//   {
//     "name": "Dr. Surya Abadi, Sp. J.P.",
//     "category": "Cardiologist",
//     "exp": "5",
//     "rating": "4.9",
//     "schedule": "Next Schedule : Monday 08:00 - 09:00",
//     "price": "Rp 200.000",
//     "image": "assets/images/orang/dokter/dr_surya.png" // Add image asset path here
//   },
// ];


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
  late String accessToken;

  @override
  void initState() {
    super.initState();
    _initializeAccessToken();
    _fetchDoctorByRelasiId(widget.relasiRsPoliId);
  }

  void _initializeAccessToken() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    accessToken = responseBodyMap['access_token'];
  }

  Future<void> _fetchDoctorByRelasiId(String relasiRsPoliId) async {
    
    final _doctorList = await Provider.of<DoctorAPI>(context, listen: false).fetchDataAllDoctor(accessToken);
    // final _poliList = await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false).fetchData(accessToken);
    List<RelasiRsPoliDoctor> relasiRsPoliDoctorList = await Provider.of<DoctorAPI>(context, listen: false).fetchRelasiRsPoliDoctorByRelasiId(relasiRsPoliId, accessToken);
    List<Map<String, dynamic>> result = [];
    // print("SEBELUM PROSES JOIN");
    for (var relasi in relasiRsPoliDoctorList) {
      // print("RELASI-JOIN-FOR");
      var combinedData = {
        // 'healthFacility': _healthFacilityList.firstWhere((hf) => hf.id == relasi.rsId),
        'doctor': _doctorList.firstWhere((d) => d.id == relasi.doctorId),
        // 'rsId': relasi.rsId,
        // 'poliId': relasi.poliId,
        'id': relasi.id
      };
      // print("ABIS BIKIN COMBINED");
      result.add(combinedData);
    }
    // print("INI LIST JOIN");
    //   print(result);
    setState(() {
      doctorList = result;
      // print("INI INSPECT DOCTOR");
      // print(inspect(doctorList));
      // print(specialistAndPolyclinicListResponse);
    });
  }

  @override
  Widget build(BuildContext context) {
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
              print("TEST");
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
                                item['doctor'].spesialisasi,
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
                                          item['doctor'].pengalaman,
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

                              Text(
                                // item["schedule"],
                                "Jadwal Dokter (?)",
                                style: const TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      // item["price"],
                                      "Harga (?)",
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
                                      //   MaterialPageRoute(builder: (context) => DoctorDetailPage()),
                                      // );
                                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) 
                                      // {
                                      //   Map<dynamic, dynamic> hospitalDetails = 
                                      //     {
                                      //       // "topImage": topImage[index],
                                      //       // "logo": imageUrls[index],
                                      //       // "nama": imageTexts[index],
                                      //       // "jenis": additionalTexts[index],
                                      //       // "jarak": distances[index],
                                      //       // "rating": rating[index],
                                      //       // "address": address[index],
                                      //       // "profile": profile[index],
                                      //       "name": item["name"],
                                      //       "category": item["category"],
                                      //       "exp": item["exp"],
                                      //       "rating": item["rating"],
                                      //       "schedule": item["schedule"],
                                      //       "price": item["price"],
                                      //       "image": item["image"]
                                      //     }
                                      //   ;
                                      //       return (DetailDoctorPage(doctorDetails: hospitalDetails, responseBody: widget.responseBody, profileId: widget.profileId, healthFacilityId: "1",));
                                      // }
                                      // ));
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
