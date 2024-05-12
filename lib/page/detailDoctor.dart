import 'package:flutter/material.dart';

class DetailDoctorPage extends StatefulWidget {
  final Map<dynamic, dynamic> doctorDetails;
  const DetailDoctorPage({Key? key, required this.doctorDetails}) : super(key: key);

  @override
  State<DetailDoctorPage> createState() => _DetailDoctorState();
}

class _DetailDoctorState extends State<DetailDoctorPage>
{
  Map<String, String> hospitalDetails = 
  {
    "topImage": 'rs_mayapada.png',
    "logo": 'assets/images/Booking/Logo/logo rs mayapada.png',
    "nama": 'Mayapada Hospital\nBandung',
    "jenis": 'General Hospital',
    "jarak": '1.2',
    "rating": '5.0',
    "address": 'Jl. Terusan Buah Batu No.5,\nBatununggal, Kec. Bandung Kidul, Kota\nBandung, Jawa Barat 40266',
    "profile": 'Mayapada Hospital is one of the best private hospitals founded by Mayapada Healthcare Group on June 1 2008.',
  };

  List<Map<dynamic, dynamic>> jadwalDokter = 
  [
    {
      "hari": "Thu", 
      "tanggal": "18",
      "availableTime": ["09:00", "10:00"],
    },

    {
      "hari": "Fri", 
      "tanggal": "19",
      "availableTime": ["10:00", "11:00", "16:00"],
    },

    {
      "hari": "Sat", 
      "tanggal": "20",
      "availableTime": ["08:00", "10:00", "14:00"],
    },

    {
      "hari": "Sun", 
      "tanggal": "21",
      "availableTime": ["11:00", "13:00", "14:00", "15:00"],
    },
  ];

  Map<dynamic, dynamic> selectedJadwalDokter = 
  {
    "hari": "Thu", 
    "tanggal": "18",
    "availableTime": ["09:00", "10:00"],
  };

  Map<dynamic, dynamic> defaultSelectedJadwal = 
  {
    "hari": "Thu", 
    "tanggal": "18",
    "availableTime": ["09:00", "10:00"],
  };

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      home: Scaffold
      (
        appBar: AppBar
        (
          leading: Container
          (
            decoration: BoxDecoration
            (
              color: Colors.white,
              borderRadius: BorderRadius.circular(100)
            ),
            child: IconButton
            (
              icon: const Icon
              (
                Icons.arrow_back_ios, 
                color: Color.fromARGB(255, 54, 84, 134),
              ),
              onPressed: () {
                Navigator.pop(context); // Kembali ke layar sebelumnya
              },
            ),
          ),
        ),
        body: SingleChildScrollView
        (
          child: Padding
          (
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column // kolom paling luar
            (
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                Center // foto dokter
                (
                  child: Container
                  (
                    width: 150, // Adjust the width as needed
                    height: 150, // Adjust the height as needed 
                    decoration: BoxDecoration
                    (
                      shape: BoxShape.circle,
                      image: DecorationImage
                      (
                        // fit: BoxFit.fill,
                        fit: BoxFit.cover,
                        image: AssetImage(widget.doctorDetails['image']),
                      ),
                    ),
                  ),
                  // child: CircleAvatar
                  // (
                  //   radius: 35,
                  //   backgroundImage: AssetImage(widget.doctorDetails['image']),
                  // ),
                ),
          
                SizedBox(height: 10), // jarak antar foto dan nama
                 // 
                Row // nama, rating, experience
                (
                  children: 
                  [
                    Expanded // nama dokter
                    (
                      child: Text
                      (
                        widget.doctorDetails['name'],
                        style: const TextStyle
                        (
                          color: Color(0xFF090F47),
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                        ),
                      ),
                    ),
                    Column // rating dan exp
                    (
                      children: 
                      [
                        Container // rating
                        (
                          decoration: BoxDecoration
                          (
                            color: const Color.fromARGB(128, 231, 231, 231),
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Row // icon dan text
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
                                widget.doctorDetails['rating'],
                                style: const TextStyle
                                (
                                  color: Color.fromARGB(255, 9, 15, 71)
                                ),
                              )
                            ],
                          ), 
                        ),
          
                        const SizedBox(height: 5),
          
                        Container // exp
                        (
                          decoration: BoxDecoration
                          (
                            color: const Color.fromARGB(128, 231, 231, 231),
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Row // icon dan text
                          ( 
                            children: 
                            [
                              const Icon
                              (
                                Icons.business_center_rounded,
                                color: Colors.black,
                              ),
                              Text
                              (
                                '${widget.doctorDetails['exp']} Year',
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
          
                const SizedBox(height: 8),
          
                Text // specialist
                (
                  widget.doctorDetails['category']!,
                  style: const TextStyle
                  (
                    color: Color.fromARGB(255, 143, 143, 143)
                  ),
                ),
          
                const SizedBox(height: 8),
          
                Container // garis abu
                (
                  decoration: const BoxDecoration
                  (
                    border: Border
                    (
                      bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1.5),
                    ),
                  ),
                ),
          
                const SizedBox(height: 8),
          
                Row // detail hospital
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
                            hospitalDetails['nama']!,
                            style: const TextStyle
                            (
                              color: Color.fromARGB(255, 9, 15, 71),
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
          
                          const SizedBox(height: 5),
          
                          Text
                          (
                            hospitalDetails['address']!,
                            style: const TextStyle
                            (
                              color: Color.fromARGB(255, 143, 143, 143)
                            ),
                          ),
          
                          const SizedBox(height: 10),
          
                          Row // rating dan jarak hospital
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
                                      '${hospitalDetails['jarak']} Km',
                                      style: const TextStyle
                                      (
                                        color: Color.fromARGB(255, 9, 15, 71)
                                      ),
                                    )
                                  ],
                                ), 
                              ),
          
                              const SizedBox(width: 10),
          
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
                                      hospitalDetails['rating']!,
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
                    ),
                    Container
                    (
                      height: 125,
                      width: 125,
                      decoration: BoxDecoration
                      (
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all
                        (
                          color: Colors.black
                        ),
                      ),
                      child: Image
                      (
                        image: AssetImage
                        (
                          hospitalDetails['logo']!,
                        ),
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
          
                const SizedBox(height: 10),
          
                Container // garis abu
                (
                  decoration: const BoxDecoration
                  (
                    border: Border
                    (
                      bottom: BorderSide(color: Color(0xFFD9D9D9), width: 1.5),
                    ),
                  ),
                ),
          
                const SizedBox(height: 10),
          
                const Text
                (
                  "Payment at the Hospital",
                  style: TextStyle
                  (
                    color: Color.fromARGB(255, 62, 62, 62),
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
          
                const Text
                (
                  "Rp. 200.000",
                  style: TextStyle
                  (
                    color: Color.fromARGB(255, 62, 62, 62),
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
          
                const SizedBox(height: 10),
          
                Container
                (
                  height: 250,
                  color: const Color.fromARGB(255, 221, 222, 255),
                  child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: 
                    [
                      const Text
                      (
                        "Select your visit date & time",
                        style: TextStyle
                        (
                          color: Color.fromARGB(255, 62, 62, 62),
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      // Row
                      // (
                      //   children: jadwalDokter.map
                      //   (
                      //     (itemJadwal) => ChoiceChip
                      //     (
                      //       showCheckmark: false,
                      //       label: , 
                      //       selected: ,
                      //     )
                      //   ),
                      // ),
                      const SizedBox(height: 10), // Add some space between text and choice chips
                      Row
                      (
                        children: jadwalDokter.map<Widget>
                        (
                          (itemJadwal) 
                          {
                            return Padding
                            (
                              padding: const EdgeInsets.only(right: 20),
                              child: ChoiceChip
                              (
                                showCheckmark: false,
                                label: Text
                                (
                                  '${itemJadwal["hari"]} | ${itemJadwal["tanggal"]}',
                                  style: TextStyle
                                  (
                                    color: itemJadwal == selectedJadwalDokter
                                        ? Colors.white
                                        : const Color.fromARGB(255, 53, 55, 121),
                                  ),
                                ),
                                shape: RoundedRectangleBorder
                                (
                                  borderRadius: BorderRadius.circular(13),
                                  // side: BorderSide.none
                                ),
                                selected: itemJadwal == selectedJadwalDokter,
                                selectedColor: const Color.fromARGB(255, 53, 55, 121),
                                backgroundColor: const Color.fromARGB(255, 235, 235, 255),
                                onSelected: (selected) 
                                {
                                  // Tambahkan fungsi untuk menangani pemilihan chip
                                  setState(() {
                                    selectedJadwalDokter = selected ? itemJadwal : defaultSelectedJadwal;
                                  });
                              
                                  if (selected) 
                                  {
                                    // Lakukan sesuatu ketika chip dipilih
                                  }
                                },
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}