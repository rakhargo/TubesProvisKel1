import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:medimate/provider/api/specialistAndPoliclinic_api.dart';
import 'package:medimate/provider/model/healthFacility_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medimate/page/doctor_profile.dart';
import 'package:medimate/provider/api/healthFacility_api.dart';

class HospitalPage extends StatefulWidget {
  // final Map<String, dynamic> hospitalDetails;
  final String profileId;
  final String idFaskes;
  final String responseBody;

  const HospitalPage({Key? key, required this.idFaskes, required this.responseBody, required this.profileId}) : super(key: key);

  @override
  State<HospitalPage> createState() => _HospitalState();
}

class _HospitalState extends State<HospitalPage>
{
  HealthFacility faskesDetails = HealthFacility
  (
    id: "",
    namaFasilitas: "",
    alamatFasilitas: "",
    kecamatanFasilitas: "",
    kotaKabFasilitas: "",
    kodePosFasilitas: "",
    tingkatFasilitas: "",
    jumlahPoliklinik: "",
    daftarPoliklinik: "",
    fotoFaskes: "",
    logoFaskes: "",
  );
  // List<dynamic> specialistAndPolyclinicList = [];
  List<Map<String, dynamic>> specialistAndPolyclinicList = [];
  late String accessToken;

  @override
  void initState() {
    super.initState();
    _initializeAccessToken();
    _fetchFaskesById();
    _fetchPoliByFaskesId(widget.idFaskes);
  }

  void _initializeAccessToken() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    accessToken = responseBodyMap['access_token'];
  }

  Future<void> _fetchFaskesById() async {
    final faskesDetailsResponse =
        await Provider.of<HealthFacilityAPI>(context, listen: false)
            .fetchDataById(widget.idFaskes, accessToken); // Pass the access token here
            // print(faskesDetailsResponse);
    setState(() {
      faskesDetails = faskesDetailsResponse;
      // print(faskesDetails.fotoFaskes);
      // print(inspect(faskesDetails));
      // print(faskesDetailsResponse);
    });
  }
  
  Future<void> _fetchPoliByFaskesId(String faskesId) async {
    
    final _healthFacilityList = await Provider.of<HealthFacilityAPI>(context, listen: false).fetchDataAll(accessToken);
    final _poliList = await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false).fetchData(accessToken);
    List<RelasiRsPoli> relasiRsPoliList = await Provider.of<HealthFacilityAPI>(context, listen: false).fetchRelasiRsPoliByRsId(faskesId, accessToken);
    List<Map<String, dynamic>> result = [];
    // print("SEBELUM PROSES JOIN");
    for (var relasi in relasiRsPoliList) {
      // print("RELASI-JOIN-FOR");
      var combinedData = {
        'healthFacility': _healthFacilityList.firstWhere((hf) => hf.id == relasi.rsId),
        'poli': _poliList.firstWhere((p) => p.id == relasi.poliId),
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
      specialistAndPolyclinicList = result;
      // print("INI INSPECT POLI");
      // print(inspect(specialistAndPolyclinicList));
      // print(specialistAndPolyclinicListResponse);
    });
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      // title: widget.hospitalDetails['nama']!,
      title: faskesDetails.namaFasilitas,
      home: DefaultTabController
      (
        length: 2,
        child: Scaffold
        (
          body: Column
          (
            children: 
            [
              // Consumer<HealthFacilityAPI>
                
                  Stack
                  (
                    children: 
                    [
                      Container
                      (
                        height: 200,
                        decoration: BoxDecoration
                        (
                          image: DecorationImage
                          (
                            image: AssetImage("images/Booking/Foto/${faskesDetails.fotoFaskes.toString()}"),                            
                            // image: AssetImage("images/Booking/Foto/fotoMayapada.png"), // bisa                            
                            // image: AssetImage(pathFoto), // bisa                            
                            fit: BoxFit.cover,
                          ),
                          
                        ),
                        // child: FutureBuilder<dynamic>(
                        //   future: item.fetchImageFoto(faskesDetails.fotoFaskes, accessToken),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState ==
                        //         ConnectionState.waiting) {
                        //       return const CircularProgressIndicator();
                        //     } else if (snapshot.hasError) {
                        //       return const Icon(Icons.error);
                        //     } else if (snapshot.hasData) {
                        //       return Image.memory(
                        //         snapshot.data!.bodyBytes,
                        //         // width: 50,
                        //         // height: 50,
                        //         fit: BoxFit.cover,
                        //       );
                        //     } else {
                        //       // Show a placeholder if no data is available
                        //       return const Placeholder();
                        //     }
                        //   },
                        // ),
                        // Back button
                      ),
                      Padding
                      (
                        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0, 0),
                        child: Container
                        (
                          decoration: BoxDecoration
                          (
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: IconButton
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
                        ),
                      ),
                    ]
                  ),
              Padding
              (
                padding: const EdgeInsets.all(12.0),
                child: Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: 
                  [
                    Row
                    (
                      children: 
                      [
                        Expanded
                        (
                          child: Text
                          (
                            // widget.hospitalDetails['nama']!,
                            faskesDetails.namaFasilitas,
                            style: const TextStyle
                            (
                              color: Color(0xFF090F47),
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                            ),
                          ),
                        ),
                        // Column
                        // (
                        //   children: 
                        //   [
                        //     Container
                        //     (
                        //       decoration: BoxDecoration
                        //       (
                        //         color: const Color.fromARGB(128, 231, 231, 231),
                        //         borderRadius: BorderRadius.circular(3)
                        //       ),
                        //       child: Row
                        //       ( 
                        //         children: 
                        //         [
                        //           const Icon
                        //           (
                        //             Icons.location_on_outlined,
                        //           ),
                        //           Text
                        //           (
                        //             '${widget.hospitalDetails['jarak']} Km',
                        //             style: const TextStyle
                        //             (
                        //               color: Color.fromARGB(255, 9, 15, 71)
                        //             ),
                        //           )
                        //         ],
                        //       ), 
                        //     ),
                        //     const SizedBox(height: 5),
                        //     Container
                        //     (
                        //       decoration: BoxDecoration
                        //       (
                        //         color: const Color.fromARGB(128, 231, 231, 231),
                        //         borderRadius: BorderRadius.circular(3)
                        //       ),
                        //       child: Row
                        //       ( 
                        //         children: 
                        //         [
                        //           const Icon
                        //           (
                        //             Icons.star,
                        //             color: Colors.yellow,
                        //           ),
                        //           Text
                        //           (
                        //             widget.hospitalDetails['rating']!,
                        //             style: const TextStyle
                        //             (
                        //               color: Color.fromARGB(255, 9, 15, 71)
                        //             ),
                        //           )
                        //         ],
                        //       ), 
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text
                    (
                      // widget.hospitalDetails['jenis']!,
                      faskesDetails.tingkatFasilitas,
                      // "Tingkat",
                      style: const TextStyle
                      (
                        color: Color.fromARGB(255, 143, 143, 143)
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 10,),
              const TabBar
              (
                labelColor: Color.fromARGB(255, 9, 15, 71),
                tabs: 
                [
                  Tab
                  (
                    text: 'Services',
                  ),
                  Tab
                  (
                    text: 'Information',
                  ),
                ]
              ),
              Expanded
              (
                child: TabBarView
                (
                  children:
                  [
                    Padding
                    (
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.builder
                      (
                         shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent
                          (
                            maxCrossAxisExtent: 125, // Lebar maksimum setiap item
                            mainAxisExtent: 150,
                            crossAxisSpacing: 50
                          ),
                          // itemCount: services.length,
                          itemCount: specialistAndPolyclinicList.length,
                          itemBuilder: (context, index)
                          {  
                            // var item = services[index];
                            var item = specialistAndPolyclinicList[index];
                            return GestureDetector
                            (
                              onTap: () 
                              {
                                Navigator.push
                                (
                                  context,
                                  MaterialPageRoute(builder: (context) => DoctorProfilePage(responseBody : widget.responseBody, profileId: widget.profileId, relasiRsPoliId: item['id'], poliId: item['poli'].id, rsId: item['healthFacility'].id,)),
                                );
                              },
                              child: Container
                              (
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration
                                (
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: const Color.fromARGB(255, 9, 15, 71),),
                                  color: const Color.fromARGB(255, 235, 235, 255),
                                ),
                                child: Column
                                (
                                  children: 
                                  [
                                    Padding
                                    (
                                      padding: const EdgeInsets.all(15.0),
                                      child: Image
                                      (
                                        image: AssetImage("images/Booking/Icon/${item['poli'].icon}"),
                                      ),
                                    ),
                                    Text
                                    (
                                      item['poli'].name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle
                                      (
                                        color: Color.fromARGB(255, 9, 15, 71),
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                      ),
                    ),
                    Column
                    (
                      children: 
                      [
                        Padding
                        (
                          padding: const EdgeInsets.all(12.0),
                          child: Row
                          (
                            children: 
                            [
                              Expanded
                              (
                                child: Column
                                (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: 
                                  [
                                    const Text
                                    (
                                      'Address',
                                      style: TextStyle
                                      (
                                        color: Color.fromARGB(255, 9, 15, 71),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text
                                    (
                                      // widget.hospitalDetails['address']!,
                                      "${faskesDetails.alamatFasilitas}, ${faskesDetails.kecamatanFasilitas}, ${faskesDetails.kotaKabFasilitas}, ${faskesDetails.kodePosFasilitas}",
                                      style: const TextStyle
                                      (
                                        color: Color.fromARGB(255, 143, 143, 143)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container
                              (
                                decoration: BoxDecoration
                                (
                                  // borderRadius: BorderRadius.circular(10),
                                  border: Border.all
                                  (
                                    color: Colors.black
                                  ),
                                ),
                                height: 125,
                                child: const Image
                                (
                                  image: AssetImage
                                  (
                                    'images/Booking/maps.png'
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container
                        (
                          decoration: const BoxDecoration
                          (
                            border: Border
                            (
                              bottom: BorderSide(color: Color(0xFFD9D9D9), width: 2.5),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column
                          (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: 
                            [
                              const Text
                              (
                                'Hospital Profile',
                                style: TextStyle
                                (
                                  color: Color.fromARGB(255, 9, 15, 71),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text
                              (
                                // widget.hospitalDetails['profile']!,
                                "Ini profile ${faskesDetails.namaFasilitas}",
                                // "Profile",
                                style: const TextStyle
                                (
                                  color: Color.fromARGB(255, 143, 143, 143),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ] 
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}