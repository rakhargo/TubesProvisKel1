import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() 
{
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage>
{
  List<Map> services = 
  [
    {"servicesName": "Mental Health", "image": "mental-health.png", "linkTo": ""},
    {"servicesName": "Dermatologist", "image": "dermatologist.png", "linkTo": ""},
    {"servicesName": "Vaccination Services", "image": "vaccine.png", "linkTo": ""},
    {"servicesName": "Dentist", "image": "dentist.png", "linkTo": ""},
    {"servicesName": "Medical Check Up", "image": "medical-check.png", "linkTo": ""},
    {"servicesName": "Home Lab Services", "image": "clean-house.png", "linkTo": ""},
    {"servicesName": "Pregnancy Consultation", "image": "pregnant.png", "linkTo": ""},
    {"servicesName": "More Services", "image": "more.png", "linkTo": ""},
  ];

  // String _selectedTopic = "All";
  List<Map> topics = 
  [
    {"topicName": "All", "linkTo": ""},
    {"topicName": "Nutrition & Diet", "linkTo": ""},
    {"topicName": "Lifestyle", "linkTo": ""},
    {"topicName": "Beauty", "linkTo": ""},
  ];
  String namaUser = "John Doe";
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      home: Scaffold
      (
        appBar: AppBar
        (
          leading: const Padding
          (
            padding: EdgeInsets.only(left: 15.0, top: 3.0, bottom: 3.0),
            child: CircleAvatar
            (
              radius: 20,
              backgroundImage: AssetImage("images/orang/noah-clark.jpg"),
            ),
          ),
          title: Text
          (
            'Hi, $namaUser!',
            style: const TextStyle
            (
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 15, 71),
              fontSize: 18
            ),
          ),
          actions: 
          [
            IconButton
            (
              onPressed: () {},
              icon: const Icon
              (
                Icons.notifications_outlined,
                color: Color.fromARGB(255, 9, 15, 71)
              )
            )
          ],
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
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                GestureDetector
                (
                  // onTap: () 
                  // {
                  //   Navigator.push
                  //   (
                  //     context,
                  //     MaterialPageRoute(builder: (context) => const AccountPage()),
                  //   );
                  // },
                  child: Container
                  (
                    decoration: BoxDecoration
                    (
                      color: const Color.fromARGB(255, 32, 33, 87),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Padding
                    (
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                      child: Row
                      (
                        children: 
                        [
                          Text
                          (
                            'Tap to quick registration',
                            style: TextStyle
                            (
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                          Spacer(),
                          Icon
                          (
                            Icons.qr_code_2,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GridView.builder
                (
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent
                  (
                    maxCrossAxisExtent: 118, // Lebar maksimum setiap item
                    mainAxisExtent: 130
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) 
                  {
                    var item = services[index];
                    return GestureDetector
                    (
                      // onTap: () 
                      // {
                      //   Navigator.push
                      //   (
                      //     context,
                      //     MaterialPageRoute(builder: (context) => const AccountPage()),
                      //   );
                      // },
                      child: Column
                      (
                        children: 
                        [
                          Container
                          (
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration
                            (
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 235, 235, 255),
                            ),
                            child: Padding
                            (
                              padding: const EdgeInsets.all(15.0),
                              child: Image
                              (
                                image: AssetImage("images/service/${item['image']}"),
                              ),
                            ),
                          ),
                          Text
                          (
                            item['servicesName'],
                            textAlign: TextAlign.center,
                            style: const TextStyle
                            (
                              color: Color.fromARGB(255, 9, 15, 71),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10,),
                const Text
                (
                  'Health Article',
                  style: TextStyle
                  (
                    fontSize: 18,
                    color: Color.fromARGB(255, 9, 15, 71),
                    fontWeight: FontWeight.bold
                  ),
                ),
                // SizedBox
                // (
                //   height: 20,
                //   child: Builder
                //   (
                //     builder: (context) 
                //     {
                //       List<Map> topics = 
                //       [
                //         {"topicName": "All", "linkTo": ""},
                //         {"topicName": "Nutrition & Diet", "linkTo": ""},
                //         {"topicName": "Lifestyle", "linkTo": ""},
                //         {"topicName": "Beauty", "linkTo": ""},
                //       ];
                //       return ListView.builder
                //       (
                //         shrinkWrap: true,
                //         itemCount: topics.length,
                //         scrollDirection: Axis.horizontal,
                //         itemBuilder: (context, index) 
                //         {
                //           var item = topics[index];
                //           return Container
                //           (
                //             padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                //             decoration: const BoxDecoration
                //             (
                //                 borderRadius: BorderRadius.all(Radius.circular(12)),
                //                 color: Color.fromARGB(255, 53, 55, 121)
                //             ),
                //             margin: const EdgeInsets.only(right: 15),
                //             child: Text
                //             (
                //               item["topicName"],
                //               style: const TextStyle
                //               (
                //                 color: Colors.white,
                //               ),
                //             )
                //           );
                //         },
                //       );
                //     }
                //   )
                // )
              ],
            ),
          ),
        )
      ),
    );
  }
}

