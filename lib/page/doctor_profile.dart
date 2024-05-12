import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medimate/page/detailDoctor.dart';

void main() {
  runApp(const DoctorProfilePage());
}

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({Key? key}) : super(key: key);

  @override
  State<DoctorProfilePage> createState() => _DoctorProfileState();
}

List<Map<dynamic, dynamic>> doctorsData = [
  {
    "name": "Dr. Sisca Amartha, Sp. J.P.",
    "category": "Cardiologist",
    "exp": "5",
    "rating": "4.9",
    "schedule": "Next Schedule : Monday 08:00 - 09:00",
    "price": "Rp 200.000",
    "image": "assets/images/orang/dokter/dr_sisca.png" // Add image asset path here
  },
  {
    "name": "Dr. Saeful Baskori, Sp. J.P.",
    "category": "Cardiologist",
    "exp": "5",
    "rating": "4.9",
    "schedule": "Next Schedule : Monday 08:00 - 09:00",
    "price": "Rp 200.000",
    "image": "assets/images/orang/dokter/dr_saeful.png" // Add image asset path here
  },
  {
    "name": "Dr. Rizky Pratama, Sp. J.P.",
    "category": "Cardiologist",
    "exp": "5",
    "rating": "4.9",
    "schedule": "Next Schedule : Monday 08:00 - 09:00",
    "price": "Rp 200.000",
    "image": "assets/images/orang/dokter/dr_rizky.png" // Add image asset path here
  },
  {
    "name": "Dr. Syahid Alamsyah, Sp. J.P.",
    "category": "Cardiologist",
    "exp": "5",
    "rating": "4.9",
    "schedule": "Next Schedule : Monday 08:00 - 09:00",
    "price": "Rp 200.000",
    "image": "assets/images/orang/dokter/dr_alamsyah.png" // Add image asset path here
  },
  {
    "name": "Dr. Surya Abadi, Sp. J.P.",
    "category": "Cardiologist",
    "exp": "5",
    "rating": "4.9",
    "schedule": "Next Schedule : Monday 08:00 - 09:00",
    "price": "Rp 200.000",
    "image": "assets/images/orang/dokter/dr_surya.png" // Add image asset path here
  },
];


class _DoctorProfileState extends State<DoctorProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Account Page',
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
            itemCount: doctorsData.length,
            itemBuilder: (context, index) {
              var item = doctorsData[index];
              return buildContainer(item);
            },
          ),
        ),
      ),
    );
  }

  Widget buildContainer(Map item) {
  return Column(
    children: [
      Row(
        children: [
          Image(image: AssetImage(item["image"])),
          
          Expanded
          (
            child: Container
            (
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"],
                    style: const TextStyle(
                      color: Color(0xFF090F47),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    item["category"],
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
                              item["exp"],
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

                      Container(
                        width: 65, // Adjust width as needed
                        height: 30, // Adjust height as needed
                        decoration: BoxDecoration(
                          color: Color(0x80E7E7E7),
                          borderRadius: BorderRadius.circular(8
                          ), // Adjust border radius as needed

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color : Color(0xFFFFC90A)
                            ), // You can replace this with your desired icon
                            SizedBox(width: 5), // Add some spacing between the icon and text
                            Text(
                              item["rating"], // Replace with your rating value
                              style: const TextStyle(
                                color: Color(0xFF090F47),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),                
                    ],
                  ),

                  Text(
                    item["schedule"],
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
                          item["price"],
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) 
                          {
                            Map<dynamic, dynamic> hospitalDetails = 
                              {
                                // "topImage": topImage[index],
                                // "logo": imageUrls[index],
                                // "nama": imageTexts[index],
                                // "jenis": additionalTexts[index],
                                // "jarak": distances[index],
                                // "rating": rating[index],
                                // "address": address[index],
                                // "profile": profile[index],
                                "name": item["name"],
                                "category": item["category"],
                                "exp": item["exp"],
                                "rating": item["rating"],
                                "schedule": item["schedule"],
                                "price": item["price"],
                                "image": item["image"]
                              }
                            ;
                                return (DetailDoctorPage(doctorDetails: hospitalDetails));
                          }));
                        },
                        child: buildButton('Book')
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
}

  Widget buildButton(String text) {
    return Container(
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
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
