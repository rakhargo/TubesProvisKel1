import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:medimate/provider/api/healthFacility_api.dart';
import 'package:medimate/provider/model/healthFacility_model.dart';
import 'package:medimate/provider/api/doctor_api.dart';
import 'package:medimate/provider/model/doctor_model.dart';
import 'package:medimate/provider/api/specialistAndPoliclinic_api.dart';
import 'package:medimate/provider/model/specialistAndPolyclinic_model.dart';
import 'Payment/choose_payment_method.dart';
import 'bookingSummary.dart';

class DetailDoctorPage extends StatefulWidget {
  // final Map<dynamic, dynamic> doctorDetails;
  final String responseBody;
  final String profileId;
  final String healthFacilityId;
  final String doctorId;
  final String poliId;
  final int harga;

  const DetailDoctorPage({Key? key, required this.responseBody, required this.profileId, required this.healthFacilityId, required this.doctorId, required this.poliId, required this.harga}) : super(key: key);

  @override
  State<DetailDoctorPage> createState() => _DetailDoctorState();
}

class _DetailDoctorState extends State<DetailDoctorPage>
{
  HealthFacility healthFacility = HealthFacility
  (
    id: "",
    namaFasilitas: "",
    alamatFasilitas: "",
    kecamatanFasilitas: "",
    kotaKabFasilitas: "",
    kodePosFasilitas: "",
    tingkatFasilitas: "",
    jumlahPoliklinik: "",
    daftarPoliklinik: "",
    fotoFaskes: "",
    logoFaskes: "",
  );

  Doctor doctor = Doctor
  (
    id: "",
    nama: "",
    polyId: "",
    pengalaman: 0,
    foto: "",
  );

  SpecialistAndPolyclinic poli = SpecialistAndPolyclinic
  (
    id: "",
    name: "",
    icon: "",
  );

  List<DoctorSchedule> doctorScheduleList = [];

  DoctorSchedule doctorSchedule = DoctorSchedule(id: "", tanggal: "", mulai: "", selesai: "", maxBooking: 0, currentBooking: 0, doctorId: "");
  List<JudulPoli> judulPoliList = [];

  late String accessToken;
  late String userId;

  String? dropdownValue;
  String judulPoliSelected = '';
  String idJudulPoliSelected = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeUserId();
    _initializeAccessToken();
    _fetchHealthFacility(widget.healthFacilityId);
    _fetchDoctor(widget.doctorId);
    _fetchPoli(widget.poliId);
    _fetchDoctorSchedule(widget.doctorId);
    _fetchJudulPoli(widget.poliId);
  }

  void _initializeUserId() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    userId = responseBodyMap['user_id'].toString();
  }

  void _initializeAccessToken() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    accessToken = responseBodyMap['access_token'];
  }

  Future<void> _fetchPoli(String poliId) async {
    print("SEBELUM RESPONSE POLI");
    final poliResponse =
        await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false)
            .fetchDataById(poliId, accessToken); // Pass the access token here
            // print(poliResponse);
    print("SETELAH RESPONSE POLI");
    setState(() {
      poli = poliResponse;
      // print(inspect(healthFacility));
    });
  }

  Future<void> _fetchHealthFacility(String healthFacilityId) async {
    print("SEBELUM RESPONSE FASKES");
    final healthFacilityResponse =
        await Provider.of<HealthFacilityAPI>(context, listen: false)
            .fetchDataById(healthFacilityId, accessToken); // Pass the access token here
            // print(healthFacilityResponse);
    print("SETELAH RESPONSE FASKES");
    setState(() {
      healthFacility = healthFacilityResponse;
      isLoading = false;
      // print(inspect(healthFacility));
    });
  }

  Future<void> _fetchDoctor(String doctorId) async {
    print("SEBELUM RESPONSE DOCTOR");
    final doctorResponse =
        await Provider.of<DoctorAPI>(context, listen: false)
            .fetchDataDoctorById(doctorId, accessToken); // Pass the access token here
    print("SETELAH RESPONSE DOCTOR");
            // print(doctorResponse);
    setState(() {
      doctor = doctorResponse;
      // print(inspect(doctor));
    });
  }

  Future<void> _fetchJudulPoli(String poliId) async {
    
    // print("SEBELUM RESPONSE DOCTOR");
    final judulPoliResponse =
        await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false)
            .fetchRelasiJudulPoliByPoliId(poliId, accessToken); // Pass the access token here
    // print("SETELAH RESPONSE DOCTOR");
            // print(doctorResponse);
            print("SBELUM SETSTATE");
    setState(() {
      judulPoliList = judulPoliResponse;
      dropdownValue = judulPoliList.first.id;
      idJudulPoliSelected = judulPoliList.first.id;
      judulPoliSelected = judulPoliList.first.judul;
      // print(inspect(judulPoliList));
    });
            print("SEETALH SETSTATE");
  }

  Future<void> _fetchDoctorSchedule(String doctorId) async {
    
    // print("SEBELUM RESPONSE DOCTOR");
    final doctorScheduleResponse =
        await Provider.of<DoctorAPI>(context, listen: false)
            .fetchDoctorScheduleByDoctorId(doctorId, accessToken); // Pass the access token here
    // print("SETELAH RESPONSE DOCTOR");
            // print(doctorResponse);
    setState(() {
      doctorScheduleList = doctorScheduleResponse;
      // print(inspect(doctorScheduleList));
    });
  }

  String scheduleStart = '';
  String scheduleEnd = '';

  String parseHari(String tanggal) {
    final DateTime dateTime = DateTime.parse(tanggal);
    final String hari = DateFormat('EEEE').format(dateTime);
    return hari;
  }
  
  String parseTanggal(String tanggal) {
    final DateTime dateTime = DateTime.parse(tanggal);
    final String formattedTanggal = DateFormat('dd').format(dateTime);
    return formattedTanggal;
  }

  int availableBook = -1;
  int antrian = -1;
  String doctorScheduleId = '';

  String selectedJadwalDokter = '';

  String defaultSelectedJadwal = '';

  bool isPilih = false;

  Widget book(int availabeBook)
  {
    if(availableBook == -1)
    {
      isPilih = false;
      return const Text
      (
        // "Pilih Tanggal dan hari terlebih dahulu",
        "Choose date first",
        style: TextStyle(color: Color.fromARGB(255, 62, 62, 62)),
      );
    }
    else if(availableBook == 0)
    {
      isPilih = false;
      return const Text
      (
        "Not available",
        // "Penuh, silahkan pilih jadwal lain",
        style: TextStyle(color: Color.fromARGB(255, 62, 62, 62)),
      );
    }
    else
    {
      // String? dropdownValue = judulPoliList.first.judul;
      return DropdownButton<String>(
        // hint: Text("Pilih keperluan"),
        value: dropdownValue,
        style: const TextStyle(color: Color.fromARGB(255, 9, 15, 71)),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value;
            isPilih = true;

            final selectedItem = judulPoliList.firstWhere((item) => item.id == value);
            idJudulPoliSelected = selectedItem.id;
            judulPoliSelected = selectedItem.judul;
          });
        },
        items: judulPoliList.map<DropdownMenuItem<String>>((item) {
          return DropdownMenuItem<String>(
            value: item.id,
            child: Text(item.judul),
          );
        }).toList(),
      );
    }
  }

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
                Consumer<DoctorAPI>
                (
                  builder: (context, item, child) {
                    return Center // foto dokter
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
                            // image: AssetImage("assets/images/orang/dokter/${doctor.foto}"),
                            image: AssetImage("assets/images/orang/dokter/${doctor.foto}"),
                          ),
                        ),
                      ),
                      // child: CircleAvatar
                      // (
                      //   radius: 35,
                      //   backgroundImage: AssetImage(widget.doctorDetails['image']),
                      // ),
                    );
                  }
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
                        // widget.doctorDetails['name'],
                        doctor.nama,
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
                        // Container // rating
                        // (
                        //   decoration: BoxDecoration
                        //   (
                        //     color: const Color.fromARGB(128, 231, 231, 231),
                        //     borderRadius: BorderRadius.circular(3)
                        //   ),
                        //   child: Row // icon dan text
                        //   ( 
                        //     children: 
                        //     [
                        //       const Icon
                        //       (
                        //         Icons.star,
                        //         color: Colors.yellow,
                        //       ),
                        //       Text
                        //       (
                        //         widget.doctorDetails['rating'],
                        //         style: const TextStyle
                        //         (
                        //           color: Color.fromARGB(255, 9, 15, 71)
                        //         ),
                        //       )
                        //     ],
                        //   ), 
                        // ),
          
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
                                '${doctor.pengalaman.toString()} Year',
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
                  // doctor.polyId,
                  poli.name,
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
          
                Consumer<HealthFacilityAPI>
                (
                  builder: (context, item, child) 
                  {
                    return Row // detail hospital
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
                                healthFacility.namaFasilitas,
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
                                "${healthFacility.alamatFasilitas}, Kec. ${healthFacility.kecamatanFasilitas}, ${healthFacility.kotaKabFasilitas}, ${healthFacility.kodePosFasilitas}",
                                style: const TextStyle
                                (
                                  color: Color.fromARGB(255, 143, 143, 143)
                                ),
                              ),
                              
                              const SizedBox(height: 10),
                              
                              // Row // rating dan jarak hospital
                              // (
                              //   children: 
                              //   [
                              //     Container
                              //     (
                              //       decoration: BoxDecoration
                              //       (
                              //         color: const Color.fromARGB(128, 231, 231, 231),
                              //         borderRadius: BorderRadius.circular(3)
                              //       ),
                              //       child: Row
                              //       ( 
                              //         children: 
                              //         [
                              //           const Icon
                              //           (
                              //             Icons.location_on_outlined,
                              //           ),
                              //           Text
                              //           (
                              //             '${healthFacility.} Km',
                              //             style: const TextStyle
                              //             (
                              //               color: Color.fromARGB(255, 9, 15, 71)
                              //             ),
                              //           )
                              //         ],
                              //       ), 
                              //     ),
                              
                              //     const SizedBox(width: 10),
                              
                              //     Container
                              //     (
                              //       decoration: BoxDecoration
                              //       (
                              //         color: const Color.fromARGB(128, 231, 231, 231),
                              //         borderRadius: BorderRadius.circular(3)
                              //       ),
                              //       child: Row
                              //       ( 
                              //         children: 
                              //         [
                              //           const Icon
                              //           (
                              //             Icons.star,
                              //             color: Colors.yellow,
                              //           ),
                              //           Text
                              //           (
                              //             hospitalDetails['rating']!,
                              //             style: const TextStyle
                              //             (
                              //               color: Color.fromARGB(255, 9, 15, 71)
                              //             ),
                              //           )
                              //         ],
                              //       ), 
                              //     ),
                              //   ],
                              // )

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
                          child: isLoading == true 
                          ? CircularProgressIndicator()
                          : Image
                          (
                            image: AssetImage
                            (
                              "images/Booking/Logo/${healthFacility.logoFaskes}"
                            ),
                            fit: BoxFit.contain,
                          ),
                        )
                      ],
                    );
                  }
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
          
                Text
                (
                  // "Rp. 200.000",
                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(widget.harga),
                  style: const TextStyle
                  (
                    color: Color.fromARGB(255, 62, 62, 62),
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
          
                const SizedBox(height: 10),
          
                Container
                (
                  height: 190,
                  color: const Color.fromARGB(255, 221, 222, 255),
                  child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: 
                    [
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text
                        (
                          "Select Schedule & Needs",
                          style: TextStyle
                          (
                            color: Color.fromARGB(255, 62, 62, 62),
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView
                        (
                          scrollDirection: Axis.horizontal,
                          child: Column
                          (
                            children: 
                            [
                              Row
                              (
                                // children: jadwalDokter.map<Widget>
                                children: doctorScheduleList.map<Widget>
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
                                          '${parseHari(itemJadwal.tanggal)} | ${parseTanggal(itemJadwal.tanggal)}',
                                          style: TextStyle
                                          (
                                            color: itemJadwal.tanggal == selectedJadwalDokter
                                                ? Colors.white
                                                : const Color.fromARGB(255, 53, 55, 121),
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder
                                        (
                                          borderRadius: BorderRadius.circular(13),
                                        ),
                                        selected: itemJadwal.tanggal == selectedJadwalDokter,
                                        selectedColor: const Color.fromARGB(255, 53, 55, 121),
                                        backgroundColor: const Color.fromARGB(255, 235, 235, 255),
                                        onSelected: (selected) 
                                        {
                                          // print(isPilih);
                                          // Tambahkan fungsi untuk menangani pemilihan chip
                                          setState(() {
                                            selectedJadwalDokter = selected ? itemJadwal.tanggal : defaultSelectedJadwal;
                                            availableBook = itemJadwal.maxBooking - itemJadwal.currentBooking;
                                            antrian = itemJadwal.currentBooking + 1;
                                            doctorSchedule = itemJadwal;
                                            scheduleStart = itemJadwal.mulai;
                                            scheduleEnd = itemJadwal.selesai;
                                            
                                            isPilih = false;
                                            // print(selectedJadwalDokter);
                                          });
                                      
                                          if (selected) 
                                          {
                                            // selectedForAppointment["hari"] = itemJadwal["hari"];
                                            // selectedForAppointment["tanggal"] = itemJadwal["tanggal"];
                                            // selectedForAppointment["selectedTime"] = "";
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                              SizedBox(height: 5,),
                              Center
                              (
                                child: Text
                                (
                                  availableBook != 0 ? "Available Schedule: $scheduleStart - $scheduleEnd" : '',
                                  // textAlign: ,
                                  style: TextStyle(color: Color.fromARGB(255, 62, 62, 62)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(height: 10),
                      Padding
                      (
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Center
                        (
                          child: Container
                          (
                            height: 50,
                            decoration: BoxDecoration
                            (
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Padding
                            (
                              padding: const EdgeInsets.all(8.0),
                              child: book(availableBook)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // SizedBox(height: 15),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar
        (
          height: 50,
          color: Colors.white,
          child: Row
          (
            mainAxisAlignment: MainAxisAlignment.start,
            children: 
            [
              Expanded
              (
                child: Text
                (
                  isPilih == false ? "Pilih jadwal dan keperluan untuk melanjutkan" : "$judulPoliSelected - ${parseHari(selectedJadwalDokter)}, $selectedJadwalDokter",
                  style: const TextStyle
                  (
                    color: Color.fromARGB(255, 62, 62, 62),
                  ),
                ),
              ),
              GestureDetector
              (
                  onTap: isPilih == true
                  ? ()  
                  {
                    Navigator.push
                    (
                      context,
                      MaterialPageRoute
                      (
                        builder: (context) 
                        { 
                          Map<String, dynamic> bookingDetails = 
                          {
                            "patientId": int.parse(widget.profileId), 
                            "doctorId": int.parse(widget.doctorId),
                            "doctorName": doctor.nama,
                            "polyId": doctor.polyId,
                            "facilityId": int.parse(widget.healthFacilityId),
                            "facilityName": healthFacility.namaFasilitas,
                            "status": "ongoing",
                            "waktu": selectedJadwalDokter,
                            "harga": widget.harga,
                            "metodePembayaran": "On The Site",
                            "antrian": antrian,
                            "relasiJudulPoliId": int.parse(idJudulPoliSelected),
                            "judulPoli": judulPoliSelected,
                            // "doctorScheduleId": doctorScheduleId,
                            "doctorSchedule": doctorSchedule,
                            // "doctorName": widget.doctorDetails['name'],
                            "specialist": poli.name,
                            // // "hospital": hospitalDetails['nama'],
                            // "patientId": int.parse(widget.profileId),
                            // "doctorId": 1,
                            // "healthFacilityId": int.parse(healthFacility.id),
                            // "hospital": healthFacility.namaFasilitas,
                            // // "alamat": hospitalDetails['address'],
                            // "price": "Rp200.000",
                            // "dateTime": "${selectedForAppointment["tanggal"]} ${selectedForAppointment["bulan"]} ${selectedForAppointment["tahun"]}, ${selectedForAppointment["selectedTime"]}",
                          };
                          return BookingSummaryPage(bookingDetails: bookingDetails, responseBody : widget.responseBody, profileId: widget.profileId,);
                          // return PaymentPage();
                        }
                      ),
                    );
                  }
                  : null,
                child: Container
                (
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.circular(13),
                    color: isPilih == false ? const Color.fromARGB(255, 219, 219, 219) : const Color.fromARGB(255, 15, 16, 53),
                  ),
                  child: Text
                  (
                    'Continue',
                    style: TextStyle
                    (
                      color: isPilih == false ? const Color.fromARGB(255, 62, 62, 62) : Colors.white,
                    ),
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