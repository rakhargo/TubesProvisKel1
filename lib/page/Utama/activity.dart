import 'package:flutter/material.dart';
import 'package:medimate/bottomNavBar.dart';

class ActivityPage extends StatefulWidget {
  final String responseBody;

  const ActivityPage({Key? key, required this.responseBody}) : super(key: key);
  
  @override
  State<ActivityPage> createState() => _ActivityState();
}

class _ActivityState extends State<ActivityPage>
{
  // int idx = 2;
  // void onItemTap(int index) {
  //    setState(() {
  //      idx = index;
  //    });
  // }

  List<Map> onGoing = 
  [
    {"title": "General Medical Check-Up", "waktu": "18 April 2024, 09.00", "dokter": "dr. Sisca Amartha, Sp. J.P.", "lokasi": "Gedung Edelweiss, 5th Floor", "rs": "Mayapada Hospital Bandung"},
    {"title": "General Medical Check-Up", "waktu": "18 April 2024, 09.00", "dokter": "dr. Sisca Amartha, Sp. J.P.", "lokasi": "Gedung Edelweiss, 5th Floor", "rs": "Mayapada Hospital Bandung"},
  ];

  List<Map> recentActivity = 
  [
    {"title": "Complete Blood Count (CBC)", "waktu": "18 February, 2024", "rs": "Mayapada Hospital Bandung"},
    {"title": "PCR Swab Test for COVID-19", "waktu": "26 January, 2024", "rs": "Rumah Sakit Hasan Sadikin"},
    {"title": "General Medical Check Up", "waktu": "7 December, 2023", "rs": "Rumah Sakit Hermina Arcamanik"},
  ];

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Activity Page',
      home: Scaffold
      (
        appBar: AppBar
        (
          title: const Text
          (
            'Activity',
            style: TextStyle
            (
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 15, 71),
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
        body: SingleChildScrollView
        (
          child: Padding
          (
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                const Padding
                (
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Text
                  (
                    "Ongoing",
                    textAlign: TextAlign.left,
                    style: TextStyle
                    (
                      color: Color.fromARGB(255, 9, 15, 71),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0
                    ),
                  ),
                ),
                const SizedBox
                (
                  height: 10,
                ),
                SizedBox
                ( 
                  height: onGoing.length * 150 + 50,
                  child: Builder
                  (
                    builder: (context) 
                    {
                      return ListView.builder
                      (
                        itemCount: onGoing.length,
                        itemBuilder: (context, index)
                        {
                          var item = onGoing[index];
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
                                      child: Text
                                      (
                                        item["title"],
                                        style: const TextStyle
                                        (
                                          color: Color.fromARGB(255, 32, 33, 87),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
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
                                      item["dokter"],
                                      style: const TextStyle
                                      (
                                        color: Color.fromARGB(216, 53, 55, 121),
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text
                                    (
                                      item["lokasi"],
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
                                        color: Color.fromARGB(216, 53, 55, 121),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Center
                                    (
                                      child: Padding
                                      (
                                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                        child: LayoutBuilder
                                        (
                                          builder: (context, constraints) 
                                          {
                                            final boxWidth = constraints.maxWidth;
                                            return Container
                                            (
                                              width: boxWidth / 2, // set the width to half of the parent container
                                              decoration: BoxDecoration
                                              (
                                                color: const Color.fromARGB(204, 53, 55, 121),
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
                                                    Icons.pin_drop_outlined,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                  SizedBox(width: 6.0),
                                                  Text
                                                  (
                                                    'View on maps',
                                                    style: TextStyle
                                                    (
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )
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
                Row
                (
                  children: 
                  [
                    const Padding
                    (
                      padding: EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Text
                      (
                        "Recent",
                        textAlign: TextAlign.left,
                        style: TextStyle
                        (
                          color: Color.fromARGB(255, 9, 15, 71),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton
                    (
                      style: TextButton.styleFrom
                      (
                        foregroundColor: const Color.fromARGB(255, 9, 15, 71),
                      ),
                      onPressed: (){}, // ke laman see more
                      child: const Text("See More"),
                    )
                  ],
                ),
                const SizedBox
                (
                  height: 10,
                ),
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
      ),
    );
  }
}
