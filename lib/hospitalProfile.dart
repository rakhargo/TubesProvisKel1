import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HospitalPage extends StatefulWidget {
  final Map<String, String> hospitalDetails;
  const HospitalPage({Key? key, required this.hospitalDetails}) : super(key: key);

  @override
  State<HospitalPage> createState() => _HospitalState();
}

class _HospitalState extends State<HospitalPage>
{
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
                    decoration: const BoxDecoration
                    (
                      image: DecorationImage
                      (
                        image: AssetImage('images/Booking/Logo/rs_mayapada.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Back button
                  ),
                  Container
                  (
                    decoration: BoxDecoration
                    (
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: IconButton
                    (
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context); // Kembali ke layar sebelumnya
                      },
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
                    const Text("Content for Information tab"),
                    Padding
                    (
                      padding: const EdgeInsets.all(12.0),
                      child: Column
                      (
                        children: 
                        [
                          Row
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
                        ],
                      ),
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