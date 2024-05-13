import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medimate/page/hospitalProfile.dart';
import 'package:medimate/page/doctor_profile.dart';
import 'package:medimate/bottomNavBar.dart';

import 'package:provider/provider.dart';
import 'package:medimate/provider/api/specialistAndPoliclinic_api.dart';
import 'package:medimate/provider/model/specialistAndPolyclinic_model.dart';


void main() 
{
  runApp(BookingPage());
}

class BookingPage extends StatefulWidget 
{
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingState();
}

class _BookingState extends State<BookingPage>
{
  List<Map<String, dynamic>> faskes = 
  [
    {
      "topImage": 'rs_mayapada.png',
      "logo"    : 'assets/images/Booking/Logo/logo rs mayapada.png',
      "nama"    : 'Mayapada Hospital\nBandung',
      "jenis"   : 'General Hospital',
      "jarak"   : '1.2',
      "rating"  : '5.0',
      "address" : 'Jl. Terusan Buah Batu No.5,\nBatununggal, Kec. Bandung Kidul, Kota\nBandung, Jawa Barat 40266',
      "profile" : 'Mayapada Hospital is one of the best private hospitals founded by Mayapada Healthcare Group on June 1 2008.',
    },

    {
      "topImage": 'rs_mayapada.png',
      "logo"    : 'assets/images/Booking/Logo/logo rsgm unpad.png',
      "nama"    : 'RSGM Universitas\nPajajaran',
      "jenis"   : 'Specialty Hospital',
      "jarak"   : '2.5', 
      "rating"  : '2.5', 
      "address" : 'Jl. Sekeloa Selatan No.1, Lebakgede, Kecamatan Coblong, Kota Bandung, Jawa Barat 40132',
      "profile" : 'Rumah sakit',
    },

    {
      "topImage": 'rs_mayapada.png',
      "logo"    : 'images/Booking/Logo/logo_ava1.png',
      "nama"    : 'Klinik AVA\nDental Aesthetic',
      "jenis"   : 'Clinic',
      "jarak"   : '3.8',
      "rating"  : '3.8',
      "address" : 'Jl. Gatot Subroto No.91-D, Malabar, Kec. Lengkong, Kota Bandung, Jawa Barat 40262',
      "profile" : 'RS',
    },

    {
      "topImage": 'rs_mayapada.png',
      "logo"    : 'assets/images/Booking/Logo/logo rshs.png',
      "nama"    : 'Rumah Sakit\nSanto Borromeus',
      "jenis"   : 'General Hospital',
      "jarak"   : '4.1',
      "rating"  : '4.1',
      "address" : 'Jl. Ir. H. Juanda No.100, Lebakgede, Kecamatan Coblong, Kota Bandung, Jawa Barat 40132',
      "profile" : 'Rafie'
    },

  ];

  // List<Map<String, dynamic>> specialist = 
  // [
  //   {'image': 'images/Booking/Icon/cardiologist.png', 'nama': 'Cardiologist'},
  //   {'image': 'images/Booking/Icon/pulmonologist.png', 'nama': 'Pulmonologist'},
  //   {'image': 'images/Booking/Icon/dermatologist.png', 'nama': 'Dermatologist'},
  //   {'image': 'images/Booking/Icon/gynecologist.png', 'nama': 'Obgyn'},
  //   {'image': 'images/Booking/Icon/pediatric.png', 'nama': 'Pediatric'},
  //   {'image': 'images/Booking/Icon/orthopedist.png', 'nama': 'Orthopedist'},
  //   {'image': 'images/Booking/Icon/urologist.png', 'nama': 'Urologist'},
  //   {'image': 'images/Booking/Icon/neurologist.png', 'nama': 'Neurologist'},
  //   {'image': 'images/Booking/Icon/dentist.png', 'nama': 'Dentist'},
  //   {'image': 'images/Booking/Icon/Oncologist.png', 'nama': 'Oncologist'},
  //   {'image': 'images/Booking/Icon/Otolaryngologist.png', 'nama': 'Otolaryngologist'},
  //   {'image': 'images/Booking/Icon/Immunogologist.png', 'nama': 'Immunogologist'},
  // ];


  List<dynamic> specialistAndPolyclinicList = [];

  @override
  void initState() {
    super.initState();
    _fetchSpecialistAndPolyclinic();
  }

  Future<void> _fetchSpecialistAndPolyclinic() async {
    final specialistAndPolyclinicResponse = await Provider.of<SpecialistAndPolyclinicList>(context, listen: false)
      .fetchData();
    setState(() {
      specialistAndPolyclinicList = specialistAndPolyclinicResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                SingleChildScrollView
                (
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate
                    (
                      faskes.length,
                      (index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            Map<String, dynamic> hospitalDetails = faskes[index];
                            return HospitalPage(hospitalDetails: hospitalDetails);
                          }));
                        },
                        child: Container
                        (
                          width: 140,
                          height: 155,
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
                                          faskes[index]["logo"],
                                        ),
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
                                          faskes[index]["nama"],
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF0F1035),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          faskes[index]["jenis"],
                                          style: const TextStyle(
                                            fontSize: 9,
                                            color: Color(0xD8353779),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0x7FD9D9D9),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                size: 10,
                                                color: Color(0xFF353779),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${faskes[index]["jarak"]} km',
                                                style: const TextStyle(
                                                  fontSize: 8,
                                                  color: Color(0xFF353779),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                Consumer<SpecialistAndPolyclinicList>
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
                        // var item = specialist[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DoctorProfilePage()),
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
                                  child: FutureBuilder<dynamic>(
                                    future: item.fetchImage(singleItem.id),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return const Icon(Icons.error);
                                      } else if (snapshot.hasData) {
                                        return Image.memory(
                                          snapshot.data!.bodyBytes,
                                          // width: 50,
                                          // height: 50,
                                          // fit: BoxFit.cover,
                                        );
                                      } else {
                                        // Show a placeholder if no data is available
                                        return const Placeholder();
                                      }
                                    },
                                  ),
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
      ),
    );
  }
}
