import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() 
{
  runApp(const MyOrdersPage());
}

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersState();
}

  List<String> topics = 
  [
    "All", "Appointment", "Lab Test",
  ];
  String selectedTopic = "All";

  List<Map> recentActivity = 
  [
    {"title": "Complete Blood Count (CBC)", "waktu": "18 February, 2024", "rs": "Mayapada Hospital Bandung"},
    {"title": "PCR Swab Test for COVID-19", "waktu": "26 January, 2024", "rs": "Rumah Sakit Hasan Sadikin"},
    {"title": "General Medical Check Up", "waktu": "7 December, 2023", "rs": "Rumah Sakit Hermina Arcamanik"},
  ];

class _MyOrdersState extends State<MyOrdersPage>
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Account Page',
      home: Scaffold
      (
        appBar: AppBar(
          title: const Text(
            'My Orders',
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
            preferredSize: const Size.fromHeight(2.0), //Set the height of the border
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

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Transactions',
                    hintStyle: const TextStyle(
                      color: Color(0x99353779),
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF202157),
                      size: 24,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xff353779),
                        width: 3.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(top: 0),
                  ),
                ),

                const SizedBox(height: 20),

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

                SizedBox
                ( 
                  height: recentActivity.length * 120 + 50,
                  child: Builder
                  (
                    builder: (context) 
                    {
                      return ListView.builder
                      (
                        itemCount: recentActivity.length,
                        itemBuilder: (context, index)
                        {
                          var item = recentActivity[index];
                          return Column
                          (
                            children: 
                            [
                              Container
                              (
                                // height: 100,
                                decoration: BoxDecoration
                                (
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color.fromARGB(255, 113, 115, 189), width: 1.1),
                                ),
                                padding: const EdgeInsets.only(left: 14, right: 14, top: 3.4, bottom: 3.4),
                                child: Column
                                (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: 
                                  [
                                    Padding
                                    (
                                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                      child: Row
                                      (
                                        children: 
                                        [
                                          Text
                                          (
                                            item["title"],
                                            style: const TextStyle
                                            (
                                              color: Color.fromARGB(255, 32, 33, 87),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const Spacer(),
                                          const Icon
                                          (
                                            Icons.more_vert,
                                            color: Color.fromARGB(165, 32, 33, 87),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text
                                    (
                                      item["waktu"],
                                      style: const TextStyle
                                      (
                                        color: Color.fromARGB(216, 53, 55, 121),
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text
                                    (
                                      item["rs"],
                                      style: const TextStyle
                                      (
                                        color: Color.fromARGB(255, 53, 55, 121),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Padding
                                    (
                                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                      child: LayoutBuilder
                                      (
                                        builder: (context, constraints) 
                                        {
                                          final boxWidth = constraints.maxWidth;
                                          return Row
                                          (
                                            children: 
                                            [
                                              Container
                                              (
                                                width: boxWidth / 3,
                                                decoration: BoxDecoration
                                                (
                                                  color: const Color.fromARGB(255, 53, 55, 121),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                                                child: const Row
                                                (
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: 
                                                  [
                                                    Icon
                                                    (
                                                      Icons.download,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    SizedBox(width: 6.0),
                                                    Text
                                                    (
                                                      'Download',
                                                      style: TextStyle
                                                      (
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 18),
                                              Container
                                              (
                                                width: boxWidth / 3,
                                                decoration: BoxDecoration
                                                (
                                                  color: const Color.fromARGB(255, 53, 55, 121),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                                                child: const Row
                                                (
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: 
                                                  [
                                                    Icon
                                                    (
                                                      Icons.visibility_outlined,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                    SizedBox(width: 6.0),
                                                    Text
                                                    (
                                                      'View Report',
                                                      style: TextStyle
                                                      (
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      );
                    },
                  )
                ),
            ],
          ),
        ),
      ),
    );
  }
}