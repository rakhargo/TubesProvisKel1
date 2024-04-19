import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BookingPage(),
    );
  }
}

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar
        (
          title: const Text
          (
            'Booking',
            style: TextStyle
            (
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 9, 15, 71),
            ),
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5), // Spacer
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xff0F1035),
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hospital & Medical Services",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "See more" button tap
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                      elevation: MaterialStateProperty.all<double>(0),
                    ),
                    child: Text(
                      "See more",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Spacer
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ImageListView(
                          imageUrls: [
                            'https://blu-djpb.kemenkeu.go.id/images/5_1624092610504da276891e5453b002c784f824f582.jpg',
                            'https://rsgm.unpad.ac.id/wp-content/uploads/2021/03/LOGO-RSGM-UNPAD.png',
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSigPOs6PJiwnZH0Vg77SU7gwYIHUmSgRQVCJzxQ4iN71dfUhp9jJpZ2ywezbfKSwBLng&usqp=CAU',
                            'https://rsborromeus.com/wp-content/uploads/2017/02/IMG_0076.jpg',
                          ],
                          imageTexts: [
                            'Rumah Sakit Hasan Sadikin',
                            'Rumah Sakit Gigi dan Mulut Unpad',
                            'Klinik AVA\nDental Aesthetic',
                            'Rumah Sakit\nSanto Borromeus',
                          ],
                          additionalTexts: [
                            'General Hospital',
                            'Specialty Hospital',
                            'Clinic',
                            'General Hospital',
                          ],
                          distances: [
                            '1.2', // Distance for the first image
                            '2.5', // Distance for the second image
                            '3.8', // Distance for the third image
                            '4.1', // Distance for the fourth image
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Spacer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Specialist & Polyclinic",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle "See more" button tap
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                      elevation: MaterialStateProperty.all<double>(0),
                    ),
                    child: Text(
                      "See more",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Spacer
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ImageTextListView(
                          imageUrls: [
                            'https://www.clipartmax.com/png/middle/100-1006207_consultation-%E2%80%9C-general-practitioner-vector.png',
                            'https://i.pngimg.me/thumb/f/720/m2i8N4b1i8N4m2b1.jpg',
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScCDTSa-4P5ikykVPoJyedCGUUn764kZc6cg&usqp=CAU',
                            'https://img.freepik.com/free-vector/brain-chemistry-concept-illustration_114360-10136.jpg',
                          ],
                          imageTexts: [
                            'General Praciticioner',
                            'Pediatric',
                            'Dentist',
                            'Neurologist',
                          ],
                        ),
                      ),
                    ),
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

class ImageListView extends StatelessWidget {
  final List<String> imageUrls;
  final List<String> imageTexts;
  final List<String> additionalTexts;
  final List<String> distances; // List of distances

  const ImageListView({
    Key? key,
    required this.imageUrls,
    required this.imageTexts,
    required this.additionalTexts,
    required this.distances,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        imageUrls.length,
        (index) => Container(
          width: 120,
          height: 200,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xff090F47),
              width: 3,
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 5, left: 10),
                    child: Image.network(
                      imageUrls[index],
                      width: 90,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        imageTexts[index],
                        style: TextStyle(fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        additionalTexts[index],
                        style: TextStyle(fontSize: 8),
                      ),
                      SizedBox(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_pin, size: 10), // Distance icon
                          SizedBox(width: 0),
                          Text(
                            '${distances[index]} km', // Distance text
                            style: TextStyle(fontSize: 8),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageTextListView extends StatelessWidget {
  final List<String> imageUrls;
  final List<String> imageTexts;

  const ImageTextListView({
    Key? key,
    required this.imageUrls,
    required this.imageTexts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        imageUrls.length,
        (index) => Container(
          width: 120,
          height: 200,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xff090F47),
              width: 3,
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 5, left: 17),
                    child: Image.network(
                      imageUrls[index],
                      width: 80.0,
                      height: 80.0,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        imageTexts[index],
                        style: TextStyle(fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
