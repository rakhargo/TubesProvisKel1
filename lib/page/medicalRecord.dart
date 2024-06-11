import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:medimate/provider/api/profile_api.dart';
import 'package:medimate/provider/api/specialistAndPoliclinic_api.dart';
import 'package:medimate/provider/api/healthFacility_api.dart';
import 'package:medimate/provider/api/appointment_api.dart';
import 'package:medimate/provider/api/doctor_api.dart';
import 'package:medimate/provider/api/profile_api.dart';

// import 'package:medimate/provider/model/profile_model.dart';
import 'package:medimate/provider/model/specialistAndPolyclinic_model.dart';
import 'package:medimate/provider/model/healthFacility_model.dart';
import 'package:medimate/provider/model/appointment_model.dart';
import 'package:medimate/provider/model/doctor_model.dart';

import 'package:provider/provider.dart';


class MedicalRecordPage extends StatefulWidget {
  // final Map<String, dynamic> hospitalDetails;
  final String profileId;
  final String responseBody;
  final String appointmentId;
  final String relasiJudulPoliId;

  const MedicalRecordPage({Key? key, required this.responseBody, required this.profileId, required this.appointmentId, required this.relasiJudulPoliId}) : super(key: key);

  @override
  State<MedicalRecordPage> createState() => _MedicalRecordPageState();
}

class _MedicalRecordPageState extends State<MedicalRecordPage>
{
  late String accessToken;
  late String userId;

  Map<String, dynamic> medRec = {}; 
  Map<String, dynamic> appointment = {}; 

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _initializeUserId();
    _initializeAccessToken();
    // _fetchDataAppointment(widget.appointmentId);
    _fetchDataMedicalRecord(widget.appointmentId);
  }

  void _initializeUserId() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    userId = responseBodyMap['user_id'].toString();
  }

  void _initializeAccessToken() {
    final responseBodyMap = jsonDecode(widget.responseBody);
    accessToken = responseBodyMap['access_token'];
  }

  Future<void> _fetchDataMedicalRecord(String appointmentId) async 
  {
    try {
      List<Doctor> _doctorList = await Provider.of<DoctorAPI>(context, listen: false).fetchDataAllDoctor(accessToken);
      JudulPoli _judulPoli = await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false).fetchJudulPoliById(widget.relasiJudulPoliId, accessToken);
      List<HealthFacility> _faskesList = await Provider.of<HealthFacilityAPI>(context, listen: false).fetchDataAll(accessToken);
      Appointment _appointment = await Provider.of<AppointmentAPI>(context, listen: false).fetchDataById(widget.appointmentId, accessToken);
      Map<String, dynamic> result = {};
      // print("SEBELUM PROSES JOIN");

      // print("RELASI-JOIN-FOR");
      var combinedData = {
        'doctor': _doctorList.firstWhere((d) => d.id == _appointment.doctorId),
        'judulPoli': _judulPoli,
        'faskes': _faskesList.firstWhere((f) => f.id == _appointment.facilityId),
        // 'rsId': relasi.rsId,
        // 'poliId': relasi.poliId,
        'antrian': _appointment.antrian,
        'metodePembayaran': _appointment.metodePembayaran,
        'waktu': _appointment.waktu,
        'patientId': _appointment.patientId,
        'status': _appointment.status,
        'id': _appointment.id,
      };
      // print("ABIS BIKIN COMBINED");
      result = combinedData;
      
      // print("INI LIST JOIN");
      //   print(result);
      setState(() {
        appointment = result;
        // print("INI INSPECT appointment");
        // print(inspect(appointment));
        // print(specialistAndPolyclinicListResponse);
      });

      final _patient = await Provider.of<ProfileAPI>(context, listen: false).fetchDataByProfileId(widget.profileId, accessToken);
      final _relasiJudulPoli = await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false).fetchJudulPoliById(widget.relasiJudulPoliId, accessToken);
      MedicalRecord _medicalRecord = await Provider.of<AppointmentAPI>(context, listen: false).fetchMedicalRecordByAppointmentId(widget.appointmentId, accessToken);
      Map<String, dynamic> result2 = {};

      // print("SEBELUM PROSES JOIN");
      Map<String, dynamic> combinedData2 = {
        'patient': _patient,
        'judulPoli': _relasiJudulPoli,
        'appointment': appointment,
        'id': _medicalRecord.id, 

      };
      // print("ABIS BIKIN COMBINED");
      // result.add(combinedData);
      result2 = combinedData2;
      // print("INI LIST JOIN");
      //   print(result);
      setState(() {
        medRec = result2;
        isLoading = false;
        // print(inspect(medRec));
      });
    } catch (e) {
      print("Error: $e");
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
          title: const Text(
            'Medical Record',
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
        body: isLoading ? Center(child: CircularProgressIndicator()) 
        : SingleChildScrollView
        (
          child: Center
          (
            child: Padding
            (
              padding: const EdgeInsets.all(15.0),
              child: Column
              (
                children: 
                [
                  const Text
                  (
                    "Data Pasien",
                    style: TextStyle
                    (
                      color: Color.fromARGB(255, 32, 33, 87),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text
                  (
                    "Nama: ${medRec['patient'].nama}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  Text
                  (
                    "Email: ${medRec['patient'].email}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  Text
                  (
                    "Alamat: ${medRec['patient'].alamat}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  Text
                  (
                    "JenisKelamin: ${medRec['patient'].jenisKelamin}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  Text
                  (
                    "tanggalLahir: ${medRec['patient'].tanggalLahir}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  Text
                  (
                    "noTelepon: ${medRec['patient'].noTelepon}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  Text
                  (
                    "id: ${medRec['patient'].id}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 10,),
            
                  const Text
                  (
                    "Data Keluhan",
                    style: TextStyle
                    (
                      color: Color.fromARGB(255, 32, 33, 87),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text
                  (
                    "Judul: ${medRec['judulPoli'].judul}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  Text
                  (
                    "Tindakan: ${medRec['judulPoli'].tindakan}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 10,),
            
                  const Text
                  (
                    "Data Pertemuan",
                    style: TextStyle
                    (
                      color: Color.fromARGB(255, 32, 33, 87),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text
                  (
                    "Judul: ${medRec['appointment']['faskes'].namaFasilitas}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  Text
                  (
                    "alamatFasilitas: ${medRec['appointment']['faskes'].alamatFasilitas}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  Text
                  (
                    "kotaKabFasilitas: ${medRec['appointment']['faskes'].kotaKabFasilitas}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  Text
                  (
                    "Nama Dokter: ${medRec['appointment']['doctor'].nama}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 10,),
            
                  const Text
                  (
                    "Data Record",
                    style: TextStyle
                    (
                      color: Color.fromARGB(255, 32, 33, 87),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text
                  (
                    "Tanggal: ${medRec['appointment']['waktu']}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  Text
                  (
                    "Antrian: ${medRec['appointment']['antrian']}",
                    style: const TextStyle
                    (
                      color: Color.fromARGB(216, 53, 55, 121),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}