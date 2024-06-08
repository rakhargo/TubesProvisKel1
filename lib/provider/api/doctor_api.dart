import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

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
    // print("INI JSOn");
    // print(json);
    _doctor = 
      Doctor(
        id: json["id"].toString(),
        nama: json["nama"],
        spesialisasi: json["spesialisasi"],
        pengalaman: json["pengalaman"],
        foto: json["foto"],
      );
    // print("SEBELUM NOTIFY");
    notifyListeners();
    // print("DALAM SETJSON");
    // print(_doctor);
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
      Uri.parse('$url/doctor_id/$doctor_id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      print(jsonDecode(response.body));
      print("SEBELUM SETJSON");
      print(setFromJsonDoctor(jsonDecode(response.body)));
      return setFromJsonDoctor(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<RelasiRsPoliDoctor>> fetchRelasiRsPoliDoctorByRelasiId(String relasiRsPoliId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/relasi_dokter_rs_poli_relasirspoli_id/$relasiRsPoliId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<RelasiRsPoliDoctor> relasiDoctorList = data.map((e) => RelasiRsPoliDoctor.fromJson(e)).toList();
      // print("INI LIST RELASI");
      // print(inspect(relasiDoctorList));
      return relasiDoctorList;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<DoctorSchedule>> fetchDoctorScheduleByDoctorId(String doctorId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/doctor_schedule_doctor_id/$doctorId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<DoctorSchedule> doctorScheduleList = data.map((e) => DoctorSchedule.fromJson(e)).toList();
      // print("INI LIST jadwal");
      // print(inspect(doctorScheduleList));
      return doctorScheduleList;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<DoctorSchedule> updateDoctorSchedule(String doctorScheduleId, Map<String, dynamic> doctorSchedule, String accessToken) async {
    final response = await http.put(
      Uri.parse('$url/doctor_schedule/$doctorScheduleId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "tanggal": doctorSchedule['tanggal'],
        "mulai": doctorSchedule['mulai'],
        "selesai": doctorSchedule['selesai'],
        "maxBooking": doctorSchedule['maxBooking'],
        "currentBooking": doctorSchedule['currentBooking'],
        "doctorId": int.parse(doctorSchedule['doctorId']),
      })
    );
    if (response.statusCode == 200) {
      // List<dynamic> data = jsonDecode(response.body);
      // DoctorSchedule.fromJson(jsonDecode(response.body));
      // List<DoctorSchedule> doctorScheduleList = data.map((e) => DoctorSchedule.fromJson(e)).toList();
      // print("INI LIST jadwal");
      // print(inspect(doctorScheduleList));
      print('Schedule updated successfully');
      return DoctorSchedule.fromJson(jsonDecode(response.body));
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
