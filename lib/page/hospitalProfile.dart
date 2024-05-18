import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medimate/page/doctor_profile.dart';

class HospitalPage extends StatefulWidget {
  final Map<String, dynamic> hospitalDetails;
  final String responseBody;

  const HospitalPage({Key? key, required this.hospitalDetails, required this.responseBody}) : super(key: key);

  @override
  State<HospitalPage> createState() => _HospitalState();
}

class _HospitalState extends State<HospitalPage>
{
  List<Map> services = 
  [
    {"servicesName": "Cardiologist", "image": "cardiologist.png", "linkTo": ""},
    {"servicesName": "Dentist", "image": "dentist.png", "linkTo": ""},
  ];
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: widget.hospitalDetails['nama']!,
      home: DefaultTabController
      (
        length: 2,
        child: Scaffold
        (
          body: Column
          (
            children: 
            [
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
                        image: AssetImage('images/Booking/Logo/${widget.hospitalDetails['topImage']}'),
                        fit: BoxFit.cover,
                      ),
                    ),
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
                            widget.hospitalDetails['nama']!,
                            style: const TextStyle
                            (
                              color: Color(0xFF090F47),
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                            ),
                          ),
                        ),
                        Column
                        (
                          children: 
                          [
                            Container
                            (
                              decoration: BoxDecoration
                              (
                                color: const Color.fromARGB(128, 231, 231, 231),
                                borderRadius: BorderRadius.circular(3)
                              ),
                              child: Row
                              ( 
                                children: 
                                [
                                  const Icon
                                  (
                                    Icons.location_on_outlined,
                                  ),
                                  Text
                                  (
                                    '${widget.hospitalDetails['jarak']} Km',
                                    style: const TextStyle
                                    (
                                      color: Color.fromARGB(255, 9, 15, 71)
                                    ),
                                  )
                                ],
                              ), 
                            ),
                            const SizedBox(height: 5),
                            Container
                            (
                              decoration: BoxDecoration
                              (
                                color: const Color.fromARGB(128, 231, 231, 231),
                                borderRadius: BorderRadius.circular(3)
                              ),
                              child: Row
                              ( 
                                children: 
                                [
                                  const Icon
                                  (
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text
                                  (
                                    widget.hospitalDetails['rating']!,
                                    style: const TextStyle
                                    (
                                      color: Color.fromARGB(255, 9, 15, 71)
                                    ),
                                  )
                                ],
                              ), 
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text
                    (
                      widget.hospitalDetails['jenis']!,
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
                          itemCount: services.length,
                          itemBuilder: (context, index)
                          {  
                            var item = services[index];
                            return GestureDetector
                            (
                              onTap: () 
                              {
                                Navigator.push
                                (
                                  context,
                                  MaterialPageRoute(builder: (context) => DoctorProfilePage(responseBody : widget.responseBody)),
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
                                        image: AssetImage("images/Booking/Icon/${item['image']}"),
                                      ),
                                    ),
                                    Text
                                    (
                                      item['servicesName'],
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
                                      widget.hospitalDetails['address']!,
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
                                widget.hospitalDetails['profile']!,
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