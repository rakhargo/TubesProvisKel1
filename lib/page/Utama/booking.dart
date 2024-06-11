import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medimate/provider/api/healthFacility_api.dart';
import 'package:provider/provider.dart';
import 'package:medimate/page/hospitalProfile.dart';
import 'package:medimate/page/doctor_profile.dart';
import 'package:medimate/provider/api/specialistAndPoliclinic_api.dart';
import 'package:medimate/provider/model/specialistAndPolyclinic_model.dart';

import 'dart:developer';

class BookingPage extends StatefulWidget 
{
  final String responseBody;
  final String profileId;
  const BookingPage({Key? key, required this.responseBody, required this.profileId}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingState();
}

class _BookingState extends State<BookingPage>
{

  List<dynamic> faskesList = [];
  List<dynamic> specialistAndPolyclinicList = [];
  late String accessToken;

  @override
  void initState() {
    super.initState();
    _initializeAccessToken();
    _fetchSpecialistAndPolyclinic();
    _fetchFaskes();
  }

  void _initializeAccessToken() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    accessToken = responseBodyMap['access_token'];
  }

  Future<void> _fetchFaskes() async {
    final faskesResponse =
        await Provider.of<HealthFacilityAPI>(context, listen: false)
            .fetchDataAll(accessToken); // Pass the access token here
    setState(() {
      faskesList = faskesResponse;
    });
  }

  Future<void> _fetchSpecialistAndPolyclinic() async {
    final specialistAndPolyclinicResponse =
        await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false)
            .fetchData(accessToken); // Pass the access token here
    setState(() {
      specialistAndPolyclinicList = specialistAndPolyclinicResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
        appBar: AppBar
        (
          title: const Text
          (
            'Booking',
            style: TextStyle
            (
              fontWeight: FontWeight.bold,
              color: Color(0xFF091547),
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
        body: Padding
        (
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView
          (
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                const SizedBox(height: 5),
                TextField
                (
                  decoration: InputDecoration
                  (
                    hintText: 'Search services or health clinic',
                    hintStyle: const TextStyle
                    (
                      color: Color(0x99353779),
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    prefixIcon: const Icon
                    (
                      Icons.search,
                      color: Color(0xFF202157),
                      size: 24,
                    ),
                    border: OutlineInputBorder
                    (
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide
                      (
                        color: Color(0xff353779),
                        width: 3.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(top: 0),
                  ),
                ),
                const SizedBox(height: 10),
                const Text
                (
                  "Hospital & Health Clinic",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF090F47),
                  ),
                ),
                const SizedBox(height: 5),
                Consumer<HealthFacilityAPI>
                (
                  builder: (context, item, child) 
                  {
                    // print(inspect(faskesList.first));
                    return SingleChildScrollView
                    (
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate
                        (
                          faskesList.length,
                          (index) => GestureDetector
                          (
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                // Map<String, dynamic> hospitalDetails = faskesList[index];
                                String idFaskes = faskesList[index].id;
                                return HospitalPage(idFaskes: idFaskes, responseBody: widget.responseBody, profileId: widget.profileId,);
                              }));
                            },
                            child: Container
                            (
                              width: 140,
                              height: 170,
                              margin: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xffD9D9D9),
                                  width: 1,
                                ),
                              ),
                              child: Stack
                              (
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 140,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          color: Color(0xBF7173BD),
                                        ),
                                        child: ClipOval(
                                          child: Transform.scale(
                                            scale: 0.7,
                                            child: Image.asset(
                                              "images/Booking/Logo/${faskesList[index].logoFaskes}",
                                              fit: BoxFit.contain,
                                            ),
                                            // child: FutureBuilder<dynamic>(
                                            //   future: item.fetchImageLogo(faskesList[index].logoFaskes, accessToken),
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
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5),
                                            Text(
                                              faskesList[index].namaFasilitas,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Color(0xFF0F1035),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              faskesList[index].tingkatFasilitas,
                                              style: const TextStyle(
                                                fontSize: 9,
                                                color: Color(0xD8353779),
                                              ),
                                            ),
                                            const SizedBox(height: 5)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                ),

                const SizedBox(height: 15),
                Center
                (
                  child: SizedBox(
                    height: 35,
                    width: 330,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF353779)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        "View All",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text
                (
                  "Specialist & Polyclinic",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF090F47),
                  ),
                ),
                const SizedBox(height: 5),
                Consumer<SpecialistAndPolyclinicAPI>
                (
                  builder: (context, item, child) 
                  {
                    return GridView.builder
                    (
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 120, // Lebar maksimum setiap item
                        mainAxisExtent: 130,
                      ),
                      itemCount: item.specialistAndPoliclinicList.length,
                      itemBuilder: (context, index) {
                        final singleItem = item.specialistAndPoliclinicList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DoctorProfilePage(responseBody: widget.responseBody, profileId: widget.profileId, poliId: singleItem.id,)),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color.fromARGB(255, 235, 235, 255),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  // child: Image.asset
                                  // (
                                  //   "images/"
                                  // ),
                                  child: Image.asset(
                                    "images/Booking/Icon/${singleItem.icon}",
                                    fit: BoxFit.contain,
                                  ),
                                  // child: FutureBuilder<dynamic>(
                                  //   future: item.fetchImage(singleItem.id, accessToken),
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
                                  //         // fit: BoxFit.cover,
                                  //       );
                                  //     } else {
                                  //       // Show a placeholder if no data is available
                                  //       return const Placeholder();
                                  //     }
                                  //   },
                                  // ),
                                ),
                              ),
                              Text(
                                singleItem.name, 
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 9, 15, 71),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                ),

                Center
                (
                  child: SizedBox(
                    height: 35,
                    width: 330,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF353779)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        "View All",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
