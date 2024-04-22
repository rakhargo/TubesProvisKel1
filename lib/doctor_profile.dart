import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyOrdersPage());
}

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersState();
}

List<Map> doctorsData = [
  {"name": "Dr. Sisca Amartha", "category": "Cardiologist", "exp" : "5", "rating" : "4.9", "schedule" : "Next Schedule : Monday 08:00 - 09:00", "price": "Rp 200.000"},
  {"name": "Dr. Saeful Baskori", "category": "Cardiologist", "exp" : "5", "rating" : "4.9", "schedule" : "Next Schedule : Monday 08:00 - 09:00", "price": "Rp 200.000"},
  {"name": "Dr. Rizky Pratama", "category": "Cardiologist", "exp" : "5", "rating" : "4.9", "schedule" : "Next Schedule : Monday 08:00 - 09:00", "price": "Rp 200.000"},
  {"name": "Dr. Syahid Alamsyah", "category": "Cardiologist", "exp" : "5", "rating" : "4.9", "schedule" : "Next Schedule : Monday 08:00 - 09:00", "price": "Rp 200.000"},
  {"name": "Dr. Surya Abadi", "category": "Cardiologist", "exp" : "5", "rating" : "4.9", "schedule" : "Next Schedule : Monday 08:00 - 09:00", "price": "Rp 200.000"},
];

class _MyOrdersState extends State<MyOrdersPage> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                child: Builder(
                  builder: (context) {
                    return ListView.builder(
                      itemCount: doctorsData.length,
                      itemBuilder: (context, index) {
                        var item = doctorsData[index];
                        return buildContainer(item);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainer(Map item) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1),
            ),
          ),
          padding: const EdgeInsets.only(left: 14, right: 14, top: 3.4, bottom: 3.4),
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
              // Text(
              //   item["schedule"],
              //   style: const TextStyle(
              //     color: Color(0xFF828282),
              //     fontSize: 12,
              //   ),
              // ),
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
                  buildButton('Book'),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        const SizedBox(height: 10),
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
