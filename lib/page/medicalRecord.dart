import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:medimate/provider/api/profile_api.dart';
import 'package:medimate/provider/api/specialistAndPoliclinic_api.dart';
import 'package:medimate/provider/api/healthFacility_api.dart';
import 'package:medimate/provider/api/appointment_api.dart';
import 'package:medimate/provider/api/doctor_api.dart';
import 'package:provider/provider.dart';
import 'package:medimate/provider/model/specialistAndPolyclinic_model.dart';
import 'package:medimate/provider/model/healthFacility_model.dart';
import 'package:medimate/provider/model/appointment_model.dart';
import 'package:medimate/provider/model/doctor_model.dart';

class MedicalRecordPage extends StatefulWidget {
  final String profileId;
  final String responseBody;
  final String appointmentId;
  final String relasiJudulPoliId;

  const MedicalRecordPage({
    Key? key,
    required this.responseBody,
    required this.profileId,
    required this.appointmentId,
    required this.relasiJudulPoliId,
  }) : super(key: key);

  @override
  State<MedicalRecordPage> createState() => _MedicalRecordPageState();
}

class _MedicalRecordPageState extends State<MedicalRecordPage> {
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

  Future<void> _fetchDataMedicalRecord(String appointmentId) async {
    try {
      List<Doctor> _doctorList =
          await Provider.of<DoctorAPI>(context, listen: false)
              .fetchDataAllDoctor(accessToken);
      JudulPoli _judulPoli =
          await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false)
              .fetchJudulPoliById(widget.relasiJudulPoliId, accessToken);
      List<HealthFacility> _faskesList =
          await Provider.of<HealthFacilityAPI>(context, listen: false)
              .fetchDataAll(accessToken);
      Appointment _appointment =
          await Provider.of<AppointmentAPI>(context, listen: false)
              .fetchDataById(widget.appointmentId, accessToken);
      var combinedData = {
        'doctor': _doctorList.firstWhere((d) => d.id == _appointment.doctorId),
        'judulPoli': _judulPoli,
        'faskes': _faskesList.firstWhere((f) => f.id == _appointment.facilityId),
        'antrian': _appointment.antrian,
        'metodePembayaran': _appointment.metodePembayaran,
        'waktu': _appointment.waktu,
        'patientId': _appointment.patientId,
        'status': _appointment.status,
        'id': _appointment.id,
      };

      setState(() {
        appointment = combinedData;
      });

      final _patient = await Provider.of<ProfileAPI>(context, listen: false)
          .fetchDataByProfileId(widget.profileId, accessToken);
      final _relasiJudulPoli =
          await Provider.of<SpecialistAndPolyclinicAPI>(context, listen: false)
              .fetchJudulPoliById(widget.relasiJudulPoliId, accessToken);
      MedicalRecord _medicalRecord =
          await Provider.of<AppointmentAPI>(context, listen: false)
              .fetchMedicalRecordByAppointmentId(
                  widget.appointmentId, accessToken);
      var combinedData2 = {
        'patient': _patient,
        'judulPoli': _relasiJudulPoli,
        'appointment': appointment,
        'id': _medicalRecord.id,
      };

      setState(() {
        medRec = combinedData2;
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
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
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(title: "Data Pasien"),
                      DataText(label: "Nama", value: medRec['patient'].nama),
                      DataText(label: "Email", value: medRec['patient'].email),
                      DataText(
                          label: "Alamat", value: medRec['patient'].alamat),
                      DataText(
                          label: "Jenis Kelamin",
                          value: medRec['patient'].jenisKelamin),
                      DataText(
                          label: "Tanggal Lahir",
                          value: medRec['patient'].tanggalLahir),
                      DataText(
                          label: "No Telepon",
                          value: medRec['patient'].noTelepon),
                      const SizedBox(height: 20),
                      const SectionTitle(title: "Data Keluhan"),
                      DataText(
                          label: "Judul", value: medRec['judulPoli'].judul),
                      DataText(
                          label: "Tindakan",
                          value: medRec['judulPoli'].tindakan),
                      const SizedBox(height: 20),
                      const SectionTitle(title: "Data Pertemuan"),
                      DataText(
                          label: "Fasilitas",
                          value: medRec['appointment']['faskes'].namaFasilitas),
                      DataText(
                          label: "Alamat Fasilitas",
                          value:
                              medRec['appointment']['faskes'].alamatFasilitas),
                      DataText(
                          label: "Kota/Kab Fasilitas",
                          value: medRec['appointment']['faskes']
                              .kotaKabFasilitas),
                      DataText(
                          label: "Nama Dokter",
                          value: medRec['appointment']['doctor'].nama),
                      const SizedBox(height: 20),
                      const SectionTitle(title: "Data Record"),
                      DataText(
                          label: "Tanggal",
                          value: medRec['appointment']['waktu']),
                      DataText(
                          label: "Antrian",
                          value: medRec['appointment']['antrian'].toString()),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(255, 32, 33, 87),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class DataText extends StatelessWidget {
  final String label;
  final String value;

  const DataText({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              color: Color.fromARGB(216, 53, 55, 121),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color.fromARGB(216, 53, 55, 121),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
