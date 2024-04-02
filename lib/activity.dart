import 'package:flutter/material.dart';

void main() 
{
  runApp(const Activity());
}

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity>
{
  int idx = 2;
  void onItemTap(int index) {
     setState(() {
       idx = index;
     });
  }

  List<Map> onGoing = 
  [
    {"title": "Kontrol Jantung", "dokter": "dr. Ahmad Jason Raven", "lokasi": "B-305, Gedung Tulip", "rs": "Rumah Sakit Hasan Sadikin", "image": "jantung2.png"},
    {"title": "Cek Gula Darah", "dokter": "dr. Lula Kamila", "lokasi": "C-102, Gedung Maria", "rs": "Rumah Sakit Santo Borromeus", "image": "dalam.png"},
    {"title": "Operasi Saraf Kejepit", "dokter": "dr. Sofiatur Rohmi", "lokasi": "S-305, Gedung B", "rs": "Rumah Sakit Santosa", "image": "saraf.png"} 
  ];

  List<Map> recentActivity = 
  [
    {"title": "Operasi Usus Buntu", "dokter": "dr. Ahmad Taufiq", "lokasi": "B-303, Gedung Tulip", "rs": "Rumah Sakit Hasan Sadikin", "image": "dalam.png"},
    {"title": "Pasang Ring Jantung", "dokter": "dr. Thamy Sabru", "lokasi": "C-102, Gedung Maria", "rs": "Rumah Sakit Santo Borromeus", "image": "jantung2.png"},
    {"title": "Operasi Batu Ginjal", "dokter": "dr. Yahya Margono", "lokasi": "S-301, Gedung B", "rs": "Rumah Sakit Santosa", "image": "dalam.png"} 
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
                const Text
                (
                  "Ongoing",
                  textAlign: TextAlign.left,
                  style: TextStyle
                  (
                    color: Color.fromARGB(255, 9, 15, 71),
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0
                  ),
                ),
                const SizedBox
                (
                  height: 4,
                ),
                SizedBox
                ( 
                  height: onGoing.length * 82.4 + 50,
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
                                height: 82.4,
                                decoration: BoxDecoration
                                (
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color.fromARGB(255, 9, 15, 71), width: 1.8),
                                ),
                                padding: const EdgeInsets.only(left: 14, right: 3.4, top: 3.4, bottom: 3.4),
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
                                          Text
                                          (
                                            item["title"],
                                            style: const TextStyle
                                            (
                                              color: Color.fromARGB(255, 9, 15, 71),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text
                                          (
                                            item["dokter"],
                                            style: const TextStyle
                                            (
                                              color: Color.fromARGB(255, 9, 15, 71),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text
                                          (
                                            item["lokasi"],
                                            style: const TextStyle
                                            (
                                              color: Color.fromARGB(255, 9, 15, 71),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text
                                          (
                                            item["rs"],
                                            style: const TextStyle
                                            (
                                              color: Color.fromARGB(255, 9, 15, 71),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container
                                    (
                                      height: 70,
                                      decoration: BoxDecoration
                                      (
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: const Color.fromARGB(255, 9, 15, 71), width: 1.8),
                                      ),
                                      child: Image.asset('images/${item["image"]}', fit: BoxFit.cover)                     
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
                    const Text
                    (
                      "Recent Activity",
                      textAlign: TextAlign.left,
                      style: TextStyle
                      (
                        color: Color.fromARGB(255, 9, 15, 71),
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0
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
                  height: 4,
                ),
                SizedBox
                ( 
                  height: recentActivity.length * 82.4 + 50,
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
                                height: 82.4,
                                decoration: BoxDecoration
                                (
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color.fromARGB(255, 9, 15, 71), width: 1.8),
                                ),
                                padding: const EdgeInsets.only(left: 14, right: 3.4, top: 3.4, bottom: 3.4),
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
                                          Text
                                          (
                                            item["title"],
                                            style: const TextStyle
                                            (
                                              color: Color.fromARGB(255, 9, 15, 71),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text
                                          (
                                            item["dokter"],
                                            style: const TextStyle
                                            (
                                              color: Color.fromARGB(255, 9, 15, 71),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text
                                          (
                                            item["lokasi"],
                                            style: const TextStyle
                                            (
                                              color: Color.fromARGB(255, 9, 15, 71),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text
                                          (
                                            item["rs"],
                                            style: const TextStyle
                                            (
                                              color: Color.fromARGB(255, 9, 15, 71),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container
                                    (
                                      height: 70,
                                      decoration: BoxDecoration
                                      (
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: const Color.fromARGB(255, 9, 15, 71), width: 1.8),
                                      ),
                                      child: Image.asset('images/${item["image"]}', fit: BoxFit.cover)                     
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
        bottomNavigationBar: BottomNavigationBar
        (
          currentIndex: idx,
          selectedItemColor: const Color.fromARGB(255, 9, 15, 71),
          selectedLabelStyle: const  TextStyle(color: Color.fromARGB(180, 9, 15, 71), fontWeight: FontWeight.bold),
          unselectedItemColor: const Color.fromARGB(180, 9, 15, 71),
          onTap: onItemTap,
          items: const <BottomNavigationBarItem>
          [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.content_paste), label: "Booking"),
            BottomNavigationBarItem(icon: Icon(Icons.monitor_heart), label: "Activity"),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "Account"),
          ],
        ),
      ),
    );
  }
}
