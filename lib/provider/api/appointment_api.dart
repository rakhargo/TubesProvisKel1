import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:medimate/provider/model/article_model.dart';
import 'dart:convert';
import 'dart:developer';

import '/provider/model/appointment_model.dart';

class AppointmentAPI with ChangeNotifier {
  final String url = 'http://127.0.0.1:8000';
  List<Appointment> _appointmentList = [];
  List<Appointment> get appointmentList => _appointmentList;

  Appointment _appointment = Appointment
  (
    id: "",
    patientId: "",
    doctorId: "",
    facilityId: "",
    status: "",
    waktu: "",
    metodePembayaran: "",
    antrian: 0,
    relasiJudulPoliId: "",
  );
  Appointment get appointment => _appointment;

  List<Appointment> setFromJsonList(List<dynamic> json) {
    _appointmentList = json
        .map((e) => Appointment
        (
              id: e["id"].toString(),
              patientId: e["patientId"].toString(),
              doctorId: e["doctorId"].toString(),
              facilityId: e["facilityId"].toString(),
              status: e["status"],
              waktu: e["waktu"],
              metodePembayaran: e["metodePembayaran"],
              antrian: e["antrian"],
              relasiJudulPoliId: e["relasiJudulPoliId"].toString(),
              // formattedTime: formatter.format(DateTime.parse(e["waktu"])),
            ))
        .toList();
    notifyListeners();

    return _appointmentList;
  }

  Appointment setFromJson(Map<String, dynamic> json) {
    _appointment = 
      Appointment(
        id: json["id"].toString(),
        patientId: json["patientId"].toString(),
        doctorId: json["doctorId"].toString(),
        facilityId: json["facilityId"].toString(),
        status: json["status"],
        waktu: json["waktu"],
        metodePembayaran: json["metodePembayaran"],
        antrian: json["antrian"],
        relasiJudulPoliId: json["relasiJudulPoliId"].toString(),
        // formattedTime: formatter.format(DateTime.parse(e["waktu"])),
      )
    ;
    notifyListeners();

    return _appointment;
  }

  Future<List<Appointment>> fetchDataAll(String profileId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/appointment_profile/$profileId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    // print("DATA BY PROFILE");
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
      // print(response.body);
      return setFromJsonList(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<dynamic> fetchDataById(String appointmentId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/appointment/$appointmentId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },  
    );
    // print("DATA BY PROFILE");
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
      // print(response.body);
      return setFromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Appointment> addAppointment(Map<String, dynamic> bookingDetails, String token) async {
    final response = await http.post(Uri.parse('$url/create_appointment/'), 
    headers:
    {
      'Content-Type': 'application/json',
      'Authorization': token,
    }, 
    body: jsonEncode({
      "patientId": bookingDetails['patientId'], 
      "doctorId": bookingDetails['doctorId'], 
      "facilityId": bookingDetails['facilityId'],
      "status": bookingDetails['status'],
      "waktu": bookingDetails['waktu'],
      "metodePembayaran": bookingDetails['metodePembayaran'],
      "medicalRecordId": bookingDetails['medicalRecordId'],
      "antrian": bookingDetails['antrian'],
      "relasiJudulPoliId": bookingDetails['relasiJudulPoliId'],
    })
    );
    // print("yes2");
    if (response.statusCode == 200) {
      // print('appointment added successfully');
      // print('INI JSONDECODE');
      // print(jsonDecode(response.body));
      
      return setFromJson(jsonDecode(response.body));
    } else {
      print('Failed to add appointment: ${response.reasonPhrase}');
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Appointment> updateAppointment(Map<String, dynamic> appointment, String token) async {
    // print(inspect(appointment));
    final response = await http.put(Uri.parse('$url/appointment_update/${int.parse(appointment['id'])}'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    }, 
    body: jsonEncode({
      "patientId": int.parse(appointment['patientId']), 
      "doctorId": int.parse(appointment['doctor'].id), 
      "facilityId": int.parse(appointment['faskes'].id),
      "status": "recent",
      "waktu": appointment['waktu'],
      "metodePembayaran": appointment['metodePembayaran'],
      "antrian": appointment['antrian'],
      "relasiJudulPoliId": int.parse(appointment['judulPoli'].id),
    })
    );
    // print("yes2");
    if (response.statusCode == 200) {
      print('appointment update successfully');
      return setFromJson(jsonDecode(response.body));
    } else {
      print('Failed to update appointment: ${response.reasonPhrase}');
      throw Exception(response.reasonPhrase);
    }
  }

  Future<MedicalRecord> addMedicalRecord(Map<String, dynamic> medRec, String token) async {
    final response = await http.post(Uri.parse('$url/create_medical_record/'), 
    headers:
    {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    }, 
    body: jsonEncode({
      "patientId": medRec['patientId'], 
      "date": medRec['date'], 
      "appointmentId": medRec['appointmentId'], 
      "relasiJudulPoliId": medRec['relasiJudulPoliId'], 
    })
    );
    print("yes2");
    if (response.statusCode == 200) {
      // print('appointment added successfully');
      // print('INI JSONDECODE');
      // print(jsonDecode(response.body));
      
      return MedicalRecord.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to add medrec: ${response.reasonPhrase}');
      throw Exception(response.reasonPhrase);
    }
  }

  Future<MedicalRecord> fetchMedicalRecordByAppointmentId(String appointmentId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/medical_record_appointment/$appointmentId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    // print("DATA BY PROFILE");
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
      // print(response.body);
      return MedicalRecord.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

}
