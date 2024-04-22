import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medimate/hospitalProfile.dart';
import 'package:medimate/doctor_profile.dart';

void main() 
{
  runApp(BookingPage());
}

// class BookingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BookingPage(),
//     );
//   }
// }

class BookingPage extends StatefulWidget 
{
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingState();
}

class _BookingState extends State<BookingPage>
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp
    (      
      debugShowCheckedModeBanner: false,
      title: 'Booking Page',
      home: Scaffold
      (
        appBar: AppBar
        (
          title: const Text
          (
            'Booking',
            style: TextStyle
            (
              fontWeight: FontWeight.bold,
              color: Color(0xFF091547),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search services or health clinic',
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
                const SizedBox(height: 10),
                _buildTitle("Hospital & Health Clinic"),
                _buildImageListView(
                  topImage: [
                    'rs_mayapada.png',
                    'rs_mayapada.png',
                    'rs_mayapada.png',
                    'rs_mayapada.png',
                  ],
                  imageUrls: [
                    'https://blu-djpb.kemenkeu.go.id/images/5_1624092610504da276891e5453b002c784f824f582.jpg',
                    'https://rsgm.unpad.ac.id/wp-content/uploads/2021/03/LOGO-RSGM-UNPAD.png',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSigPOs6PJiwnZH0Vg77SU7gwYIHUmSgRQVCJzxQ4iN71dfUhp9jJpZ2ywezbfKSwBLng&usqp=CAU',
                    'https://rsborromeus.com/wp-content/uploads/2017/02/IMG_0076.jpg',
                  ],
                  imageTexts: [
                    'Mayapada Hospital\nBandung',
                    'RSGM Universitas\nPajajaran',
                    'Klinik AVA\nDental Aesthetic',
                    'Rumah Sakit\nSanto Borromeus',
                  ],
                  additionalTexts: [
                    'General Hospital',
                    'Specialty Hospital',
                    'Clinic',
                    'General Hospital',
                  ],
                  distances: ['1.2', '2.5', '3.8', '4.1'],
                  rating: ['1.2', '2.5', '3.8', '4.1'],
                  address: 
                  [
                    'Jl. Terusan Buah Batu No.5,\nBatununggal, Kec. Bandung Kidul, Kota\nBandung, Jawa Barat 40266',
                    'Jl. Sekeloa Selatan No.1, Lebakgede, Kecamatan Coblong, Kota Bandung, Jawa Barat 40132',
                    'Jl. Gatot Subroto No.91-D, Malabar, Kec. Lengkong, Kota Bandung, Jawa Barat 40262',
                    'Jl. Ir. H. Juanda No.100, Lebakgede, Kecamatan Coblong, Kota Bandung, Jawa Barat 40132',
                  ],
                  profile: 
                  [
                    'Rumah sakit gadung',
                    'Rumah sakit',
                    'RS',
                    'Rafie'
                  ]
                ),
                const SizedBox(height: 15),
                _buildButton("View All"),
                const SizedBox(height: 10),
                _buildTitle("Hospital & Health Clinic"),
                _buildImageTextListView(
                  assetPaths: [
                    'images/Booking/Icon/cardiologist.png',
                    'images/Booking/Icon/pulmonologist.png',
                    'images/Booking/Icon/dermatologist.png',
                    'images/Booking/Icon/gynecologist.png',
                    'images/Booking/Icon/pediatric.png',
                    'images/Booking/Icon/orthopedist.png',
                    'images/Booking/Icon/urologist.png',
                    'images/Booking/Icon/neurologist.png',
                    'images/Booking/Icon/dentist.png',
                    'images/Booking/Icon/Oncologist.png',
                    'images/Booking/Icon/Otolaryngologist.png',
                    'images/Booking/Icon/Immunogologist.png',
                  ],
                  imageTexts: [
                    'Cardiologist',
                    'Pulmonologist',
                    'Dermatologist',
                    'Obgyn',
                    'Pediatric',
                    'Orthopedist',
                    'Urologist',
                    'Neurologist',
                    'Dentist',
                    'Oncologist',
                    'Otolaryngologist',
                    'Immunogologist',
                  ],
                ),
                _buildButton("View All"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF090F47),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String text) {
    return Center(
      child: SizedBox(
        height: 35,
        width: 330,
        child: TextButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF353779)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageListView({
    required List<String> topImage,
    required List<String> imageUrls,
    required List<String> imageTexts,
    required List<String> additionalTexts,
    required List<String> distances,
    required List<String> rating,
    required List<String> address,
    required List<String> profile,
  }) {
    return SingleChildScrollView
    (
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          imageUrls.length,
          (index) => GestureDetector
          (
            onTap: () 
            {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) 
              {
                Map<String, String> hospitalDetails = 
                  {
                    "topImage": topImage[index],
                    "logo": imageUrls[index],
                    "nama": imageTexts[index],
                    "jenis": additionalTexts[index],
                    "jarak": distances[index],
                    "rating": rating[index],
                    "address": address[index],
                    "profile": profile[index],
                  }
                ;
                    return (HospitalPage(hospitalDetails: hospitalDetails));
               }));
            },
            child: Container(
              width: 140,
              height: 155,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xffD9D9D9),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 140,
                        height: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Color(0xBF7173BD),
                        ),
                        child: ClipOval(
                          child: Transform.scale(
                            scale: 0.7,
                            child: Image.network(
                              imageUrls[index],
                              fit: BoxFit.fitWidth,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return Container(
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60.0, left: 10),
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                imageTexts[index],
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF0F1035),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                additionalTexts[index],
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Color(0xD8353779),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0x7FD9D9D9),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined, 
                                      size: 10,
                                      color: Color(0xFF353779),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${distances[index]} km',
                                      style: const TextStyle(
                                        fontSize: 8, 
                                        color: Color(0xFF353779),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageTextListView({
    required List<String> assetPaths,
    required List<String> imageTexts,
  }) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 5,
      runSpacing: 5,
      children: List.generate(
        assetPaths.length,
        (index) => SizedBox(
          width: 89,
          height: 115,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector
              (
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorProfilePage()),
                  );
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xffEBEBFF),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Transform.scale(
                      scale: 0.6,
                      child: Image.asset(
                        assetPaths[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 3),
              Text(
                imageTexts[index],
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xff0F1035),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
