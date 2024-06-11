import 'dart:convert';
import 'package:medimate/main.dart';
import 'package:medimate/provider/api/profile_api.dart';
import 'package:medimate/provider/model/profile_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medimate/bottomNavBar.dart';
import 'package:medimate/page/CreateProfilePage.dart';
import 'package:medimate/page/articles/article1.dart';
import 'package:medimate/page/qrCodeScanner.dart';

class HomePage extends StatefulWidget {
  final String responseBody;
  final String profileId;

  const HomePage(
      {Key? key, required this.responseBody, required this.profileId})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<Map> services = [
    {
      "servicesName": "Mental Health",
      "image": "mental-health.png",
      "linkTo": ""
    },
    {
      "servicesName": "Dermatologist",
      "image": "dermatologist.png",
      "linkTo": ""
    },
    {
      "servicesName": "Vaccination Services",
      "image": "vaccine.png",
      "linkTo": ""
    },
    {"servicesName": "Dentist", "image": "dentist.png", "linkTo": ""},
    {
      "servicesName": "Medical Check Up",
      "image": "medical-check.png",
      "linkTo": ""
    },
    {
      "servicesName": "Home Lab Services",
      "image": "clean-house.png",
      "linkTo": ""
    },
    {
      "servicesName": "Book an Appointment",
      "image": "appointment.png",
      "linkTo": ""
    },
    {"servicesName": "More Services", "image": "more.png", "linkTo": ""},
  ];

  List<String> topics = [
    "All",
    "Nutrition & Diet",
    "Lifestyle",
    "Beauty",
    "Exercise"
  ];

  String selectedTopic = "All";

  List<Map> articles = [
    {
      "articleTitle":
          "Plant-based Protein: The Best, the Worst, and Everything In Between",
      "topics": ["Nutrition & Diet", "Lifestyle"],
      "image": "1.jpg",
      "link": Article1(),
    },
    {
      "articleTitle":
          "Exercise may Reduce Heart Disease Risk by Changing How the Brain Reacts to Stress",
      "topics": ["Exercise", "Lifestyle"],
      "image": "2.jpg",
      "link": Article1(),
    },
    {
      "articleTitle":
          "Why Wearing Makeup During Workouts May Be Bad for Your Skin",
      "topics": ["Beauty"],
      "image": "3.jpg",
      "link": Article1(),
    },
  ];

  List<dynamic> profileList = [];
  late String accessToken;
  late String userId;

  @override
  void initState() {
    super.initState();
    _initializeUserId();
    _initializeAccessToken();
    _fetchProfileByUserId();
    _fetchProfile(widget.profileId);
  }

  void _initializeUserId() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    userId = responseBodyMap['user_id'].toString();
  }

  void _initializeAccessToken() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    accessToken = responseBodyMap['access_token'];
  }

  Future<void> _fetchProfileByUserId() async {
    final profileListResponse =
        await Provider.of<ProfileAPI>(context, listen: false).fetchDataByUserId(
            userId, accessToken); // Pass the access token here
    // print(profileListResponse);
    setState(() {
      profileList = profileListResponse;
      // print(profileListResponse);
      // print("INI PROFILE LIST");
      // print(profileList);
    });
  }

  Profile chosenProfile = Profile(
    id: "",
    userId: "",
    nama: "",
    tanggalLahir: "",
    jenisKelamin: "",
    email: "",
    alamat: "",
    noTelepon: "",
    userPhoto: "",
    isMainProfile: "",
  );

  Future<void> _fetchProfile(String profileId) async {
    final profileResponse =
        await Provider.of<ProfileAPI>(context, listen: false)
            .fetchDataByProfileId(
                profileId, accessToken); // Pass the access token here
    // print(profileResponse);
    setState(() {
      chosenProfile = profileResponse;
      // print(profileResponse);
      // print("INI PROFILE");
      // print(chosenProfile);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(profileList);
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<ProfileAPI>(builder: (context, item, child) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 3.0, bottom: 3.0),
              child: CircleAvatar(
                radius: 20,
                // backgroundImage: AssetImage("images/orang/${chosenProfile['userPhoto']}"),
                child: FutureBuilder<dynamic>(
                  future: item.fetchImage(widget.profileId, accessToken),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.error);
                    } else if (snapshot.hasData) {
                      return Image.memory(
                        snapshot.data!.bodyBytes,
                        // width: 50,
                        // height: 50,
                        fit: BoxFit.cover,
                      );
                    } else {
                      // Show a placeholder if no data is available
                      return const Placeholder();
                    }
                  },
                ),
              ),
            ),
          );
        }),
        title: Text(
          'Hi, ${chosenProfile.nama}!',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 9, 15, 71),
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: Color.fromARGB(255, 9, 15, 71),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(2.0), // Set the height of the border
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey, // Set the color of the border
                  width: 0.5, // Set the width of the border
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey, // Set the color of the shadow
                  blurRadius: 2.0, // Set the blur radius of the shadow
                  offset: Offset(0.0, 2.0), // Set the offset of the shadow
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Builder(
        builder: (context) {
          return Drawer(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ),
                const DrawerHeader(
                  child: Text(
                    'Select Profile',
                    style: TextStyle(
                      color: Color.fromARGB(255, 9, 15, 71),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Consumer<ProfileAPI>(
                  builder: (context, item, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: profileList.length +
                          1, // Add 1 for the "Create New Profile" button
                      itemBuilder: (context, index) {
                        if (index == profileList.length) {
                          // Render the "Create New Profile" button as the last item
                          return ListTile(
                            leading: Icon(Icons
                                .add), // You can change the icon as per your design
                            title: Text("Create New Profile"),
                            onTap: () {
                              // Navigate to the page containing the create profile form
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateProfilePage(
                                        responseBody: widget.responseBody,
                                        profileId: widget.profileId)),
                              );
                            },
                          );
                        } else {
                          final profile = profileList[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              // backgroundImage: AssetImage("images/orang/${profile['profilePicture']}"),
                              child: FutureBuilder<dynamic>(
                                future:
                                    item.fetchImage(profile.id, accessToken),
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
                            title: Text(profile.nama),
                            onTap: () {
                              _fetchProfile(profile.id);
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainApp(
                                          responseBody: widget.responseBody,
                                          indexNavbar: 0,
                                          profileId: profile.id,
                                        )),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Response Body: ${widget.responseBody}',
              //   style: TextStyle(color: Colors.black),
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QRCodeScannerApp()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 32, 33, 87),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    child: Row(
                      children: [
                        Text(
                          'Tap to quick registration',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Spacer(),
                        Icon(
                          Icons.qr_code_2,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 118, // Maximum width of each item
                  mainAxisExtent: 130,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  var item = services[index];
                  return GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 235, 235, 255),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image(
                              image:
                                  AssetImage("images/service/${item['image']}"),
                            ),
                          ),
                        ),
                        Text(
                          item['servicesName'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 9, 15, 71),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Health Article',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 9, 15, 71),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: topics
                      .map((topic) => Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: ChoiceChip(
                              showCheckmark: false,
                              label: Text(
                                topic,
                                style: TextStyle(
                                  color: topic == selectedTopic
                                      ? Colors.white
                                      : const Color.fromARGB(255, 53, 55, 121),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              selected: topic == selectedTopic,
                              selectedColor:
                                  const Color.fromARGB(255, 53, 55, 121),
                              backgroundColor:
                                  const Color.fromARGB(255, 235, 235, 255),
                              onSelected: (selected) {
                                setState(() {
                                  selectedTopic = selected ? topic : "All";
                                });
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: selectedTopic == "All"
                        ? articles.map<Widget>((article) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return article['link'];
                                    }));
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           article['link']),
                                    // );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 113, 115, 189)),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        double imageWidth =
                                            constraints.maxWidth / 2.5;

                                        return Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      article['articleTitle'],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 32, 33, 87),
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Wrap(
                                                      spacing: 5,
                                                      children:
                                                          article['topics']
                                                              .map<Widget>(
                                                                  (topic) {
                                                        return Chip(
                                                          label: Text(topic),
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  53,
                                                                  55,
                                                                  121),
                                                          labelStyle: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.asset(
                                                "images/article/${article['image']}",
                                                width: imageWidth,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                              ],
                            );
                          }).toList()
                        : articles
                            .where((article) =>
                                article["topics"].contains(selectedTopic))
                            .map<Widget>((article) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              article['link']),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 113, 115, 189)),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        double imageWidth =
                                            constraints.maxWidth / 2.5;

                                        return Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      article['articleTitle'],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 32, 33, 87),
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Wrap(
                                                      spacing: 5,
                                                      children:
                                                          article['topics']
                                                              .map<Widget>(
                                                                  (topic) {
                                                        return Chip(
                                                          label: Text(topic),
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  53,
                                                                  55,
                                                                  121),
                                                          labelStyle: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.asset(
                                                "images/article/${article['image']}",
                                                width: imageWidth,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                              ],
                            );
                          }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
