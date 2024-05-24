import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:medimate/provider/model/article_model.dart';
import 'dart:convert';

import '/provider/model/appointment_model.dart';

class AppointmentAPI with ChangeNotifier {
  final String url = 'http://127.0.0.1:8000';
  List<dynamic> _appointmentList = [];
  List<dynamic> get appointmentList => _appointmentList;

  Appointment _appointment = Appointment
  (
    id: "",
    patientId: "",
    doctorId: "",
    facilityId: "",
    status: "",
    waktu: "",
    formattedTime: "",
    metodePembayaran: "",
  );
  Appointment get appointment => _appointment;

  List<dynamic> setFromJsonList(List<dynamic> json) {
    _appointmentList = json
        .map((e) => Appointment
        (
              id: e["id"].toString(),
              patientId: e["patientId"].toString(),
              doctorId: e["doctorId"].toString(),
              facilityId: e["facilityId"].toString(),
              status: e["status"],
              waktu: e["waktu"],
              formattedTime: e["waktu"],
              metodePembayaran: e["metodePembayaran"],
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
        formattedTime: json["waktu"],
        metodePembayaran: json["metodePembayaran"],
        // formattedTime: formatter.format(DateTime.parse(e["waktu"])),
      )
    ;
    notifyListeners();

    return _appointment;
  }

  Future<List> fetchDataAll(String profileId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/appointment_profile/$profileId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    // print("DATA BY USER");
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

  Future<Appointment> addAppointment(int patientId, int doctorId, int facilityId, String status, String waktu, String metodePembayaran, String token) async {
    // print("yes1");
    final response = await http.post(Uri.parse('$url/create_appointment/'), headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    }, 
    body: jsonEncode({
      "patientId": patientId, 
      "doctorId": doctorId, 
      "facilityId": facilityId,
      "status": status,
      "waktu": waktu,
      "metodePembayaran": metodePembayaran,
    })
    // body: {
    //   {"item_id": item_id, "user_id": user_id, "quantity": quantity}
    // }
    );
    // print("yes2");
    if (response.statusCode == 200) {
      print('appointmner added successfully');
      return setFromJson(jsonDecode(response.body));
    } else {
      print('Failed to add appointmenr: ${response.reasonPhrase}');
      throw Exception(response.reasonPhrase);
    }
  }

}
