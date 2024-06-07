import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/provider/model/doctor_model.dart';

class DoctorAPI with ChangeNotifier {
  final String url = 'http://127.0.0.1:8000';
  List<dynamic> _doctorList = [];
  List<dynamic> get doctorList => _doctorList;

  Doctor _doctor = Doctor
  (
    id: "",
    nama: "",
    spesialisasi: "",
    pengalaman: 0,
    foto: "",
  );
  Doctor get doctor => _doctor;

  List<dynamic> setFromJsonDoctorList(List<dynamic> json) {
    _doctorList = json
        .map((e) => Doctor(
              id: e["id"].toString(),
              nama: e["nama"],
              spesialisasi: e["spesialisasi"],
              pengalaman: e["pengalaman"],
              foto: e["foto"],
            ))
        .toList();
    notifyListeners();

    return _doctorList;
  }

  Doctor setFromJsonDoctor(Map<String, dynamic> json) {
    _doctor = 
      Doctor(
        id: json["id"].toString(),
        nama: json["nama"],
        spesialisasi: json["spesialisasi"],
        pengalaman: json["pengalaman"],
        foto: json["foto"],
      )
    ;
    notifyListeners();

    return _doctor;
  }

  Future<List> fetchDataAllDoctor(String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/doctor/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
      // print(response.body);
      return setFromJsonDoctorList(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<dynamic> fetchDataDoctorById(String doctor_id, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/doctor/$doctor_id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
      // print(response.body);
      return setFromJsonDoctor(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // Future<List> fetchDoctorsByPoliId(int poliId, String accessToken) async {
  //   final response = await http.get(
  //     Uri.parse('$url/dokter_rs_poli?poliId=$poliId'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $accessToken',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     List<dynamic> d ata = jsonDecode(response.body);
  //     List<Doctor> doctorList = data.map((e) => Doctor.fromJson(e)).toList();
  //     return doctorList;
  //   } else {
  //     throw Exception(response.reasonPhrase);
  //   }
  // }

  // Future<http.Response> fetchImage(String profile_id, String accessToken) async {
  //   final response = await http.get(
  //     Uri.parse('$url/profile_picture/$profile_id'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $accessToken',
  //     },
  //   );
  //   // print("DATA IMAGE" + response.statusCode);
  //   if (response.statusCode == 200) {
  //     return response;
  //   } else {
  //     throw Exception(response.reasonPhrase);
  //   }
  // }
}
