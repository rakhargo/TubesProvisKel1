import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medimate/qrCodeScanner.dart';

// void main() 
// {
//   runApp(const HomePage());
// }

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
    {"servicesName": "Book an Appointment", "image": "appointment.png", "linkTo": ""},
    {"servicesName": "More Services", "image": "more.png", "linkTo": ""},
  ];


  List<Map> profiles = 
  [
    {"profileName": "John Doe", "profilePicture": "1-john_doe.jpg"},
    {"profileName": "Christian Buehner", "profilePicture": "2-christian_buehner.jpg"},
    {"profileName": "Alicia Claire", "profilePicture": "3-alicia_claire.jpg"},
  ];

  int idxProfiles = 0;
  Map<dynamic, dynamic> chosenProfile = {};

  List<String> topics = 
  [
    "All", "Nutrition & Diet", "Lifestyle", "Beauty", "Exercise"
  ];

  String selectedTopic = "All";

  List<Map> articles = 
  [
    {
      "articleTitle": "Plant-based Protein: The Best, the Worst, and Everything In Between", 
      "topics": ["Nutrition & Diet", "Lifestyle"],
      "image": "1.jpg",
    },

    {
      "articleTitle": "Exercise may Reduce Heart Disease Risk by Changing How the Brain Reacts to Stress", 
      "topics": ["Exercise", "Lifestyle"],
      "image": "2.jpg",
    },

    {
      "articleTitle": "Why Wearing Makeup During Workouts May Be Bad for Your Skin", 
      "topics": ["Beauty"],
      "image": "3.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) 
  {
    chosenProfile = profiles[idxProfiles];
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Home Page',
      home: Scaffold
      (
        appBar: AppBar
        (
          leading: Builder
          (
            builder: (context) => GestureDetector
            (
              onTap: ()
              {
                Scaffold.of(context).openDrawer();
              },
              child: Padding
              (
                padding: const EdgeInsets.only(left: 15.0, top: 3.0, bottom: 3.0),
                child: CircleAvatar
                (
                  radius: 20,
                  backgroundImage: AssetImage("images/orang/${chosenProfile['profilePicture']}"),
                ),
              ),
            ),
          ),
          title: Text
          (
            'Hi, ${chosenProfile['profileName']}!',
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
        drawer: Builder
        (
          builder: (context) 
          {
            return Drawer
            (
              child: ListView
              (
                children: 
                [
                  Padding
                  (
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                    child: Align
                    (
                      alignment: Alignment.centerLeft,
                      child: IconButton
                      (
                        onPressed: ()
                        {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios)
                      ),
                    ),
                  ),
                  const DrawerHeader
                  (
                    child: Text
                    (
                      'Select Profile',
                      style: TextStyle
                      (
                        color: Color.fromARGB(255, 9, 15, 71),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder
                  (
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: profiles.length,
                    itemBuilder: (context, index)
                    {
                      final profile = profiles[index];
                      return ListTile
                      (
                        leading: CircleAvatar
                        (
                          radius: 20,
                          backgroundImage: AssetImage("images/orang/${profile['profilePicture']}"),
                        ),
                        title: Text(profile['profileName']),
                        onTap: () 
                        {
                          // Handle onTap event
                          setState(() 
                          {
                            // chosenProfile = profile;
                            idxProfiles = index;
                          });
                        //   onPressed: ()
                        // {
                          Navigator.of(context).pop();
                        // },
                        }
                      );
                    }
                  )
                ],
              ),
            );
          }
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
                  onTap: () 
                  {
                    Navigator.push
                    (
                      context,
                      MaterialPageRoute(builder: (context) => QRCodeScannerApp()),
                    );
                  },
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                SingleChildScrollView
                (
                  scrollDirection: Axis.horizontal,
                  child: Row
                  (
                    children: topics
                        .map((topic) => Padding
                        (
                          padding: const EdgeInsets.only(right: 20),
                          child: ChoiceChip
                          (
                            showCheckmark: false,
                            label: Text
                            (
                              topic,
                              style: TextStyle
                              (
                                color: topic == selectedTopic
                                    ? Colors.white
                                    : const Color.fromARGB(255, 53, 55, 121),
                              ),
                            ),
                            shape: RoundedRectangleBorder
                            (
                              borderRadius: BorderRadius.circular(13),
                              // side: BorderSide.none
                            ),
                            selected: topic == selectedTopic, // Ubah ini untuk membuat selected sesuai dengan kondisi Anda
                            selectedColor: const Color.fromARGB(255, 53, 55, 121),
                            backgroundColor: const Color.fromARGB(255, 235, 235, 255),
                            onSelected: (selected) 
                            {
                              // Tambahkan fungsi untuk menangani pemilihan chip
                              setState(() {
                                selectedTopic = selected ? topic : "All";
                              });

                              if (selected) 
                              {
                                // Lakukan sesuatu ketika chip dipilih
                              }
                            },
                          ),
                        ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),

                // Menampilkan daftar artikel yang telah difilter
                Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: selectedTopic == "All"
                      ? articles.map<Widget>((article) 
                      {
                          return Column
                          (
                            children: 
                            [
                              Container
                              (
                                decoration: BoxDecoration
                                (
                                  border: Border.all(color: const Color.fromARGB(255, 113, 115, 189)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding
                                (
                                  padding: const EdgeInsets.all(8.0),
                                  child: LayoutBuilder
                                  (
                                    builder: (context, constraints) 
                                    {
                                      // Menghitung lebar gambar (setengah dari lebar widget induk)
                                      double imageWidth = constraints.maxWidth / 2.5;
                              
                                      return Row
                                      (
                                        children: 
                                        [
                                          Expanded
                                          (
                                            child: Padding
                                            (
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column
                                              (
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: 
                                                [
                                                  Text
                                                  (
                                                    article['articleTitle'],
                                                    style: const TextStyle
                                                    (
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromARGB(255, 32, 33, 87),
                                                      fontSize: 15
                                                    ),
                                                    // max
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Wrap
                                                  (
                                                    spacing: 5, // Spasi antara setiap widget dalam Wrap
                                                    children: article['topics'].map<Widget>((topic) 
                                                    {
                                                      return Chip
                                                      (
                                                        label: Text(topic),
                                                        backgroundColor: const Color.fromARGB(255, 53, 55, 121),
                                                        labelStyle: const TextStyle(color: Colors.white),
                                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                                        
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          ClipRRect
                                          (
                                            borderRadius: BorderRadius.circular(12), // Set border circular
                                            child: Image
                                            (
                                              image: AssetImage("images/article/${article['image']}"),
                                              width: imageWidth,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15)
                            ],
                          );
                        }).toList()
                      : articles
                          .where((article) => article["topics"].contains(selectedTopic))
                          .map<Widget>((article) 
                          {
                          return Column
                          (
                            children: 
                            [
                              Container
                              (
                                decoration: BoxDecoration
                                (
                                  border: Border.all(color: const Color.fromARGB(255, 113, 115, 189)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding
                                (
                                  padding: const EdgeInsets.all(8.0),
                                  child: LayoutBuilder
                                  (
                                    builder: (context, constraints) 
                                    {
                                      // Menghitung lebar gambar (setengah dari lebar widget induk)
                                      double imageWidth = constraints.maxWidth / 2.5;
                              
                                      return Row
                                      (
                                        children: 
                                        [
                                          Expanded
                                          (
                                            child: Padding
                                            (
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column
                                              (
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: 
                                                [
                                                  Text
                                                  (
                                                    article['articleTitle'],
                                                    style: const TextStyle
                                                    (
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromARGB(255, 32, 33, 87),
                                                      fontSize: 15
                                                    ),
                                                    // max
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Wrap
                                                  (
                                                    spacing: 5, // Spasi antara setiap widget dalam Wrap
                                                    children: article['topics'].map<Widget>((topic) 
                                                    {
                                                      return Chip
                                                      (
                                                        label: Text(topic),
                                                        backgroundColor: const Color.fromARGB(255, 53, 55, 121),
                                                        labelStyle: const TextStyle(color: Colors.white),
                                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                                        
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          ClipRRect
                                          (
                                            borderRadius: BorderRadius.circular(12), // Set border circular
                                            child: Image
                                            (
                                              image: AssetImage("images/article/${article['image']}"),
                                              width: imageWidth,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          );
                        }).toList()
                ),

              ],
            ),
          ),
        )
      ),
    );
  }
}

