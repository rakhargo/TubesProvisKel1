import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import '/provider/model/doctor_model.dart';

class DoctorAPI with ChangeNotifier {
  final String url = 'http://127.0.0.1:8000';
  List<Doctor> _doctorList = [];
  List<Doctor> get doctorList => _doctorList;

  Doctor _doctor = Doctor
  (
    id: "",
    nama: "",
    polyId: "",
    pengalaman: 0,
    foto: "",
  );
  Doctor get doctor => _doctor;

  List<Doctor> setFromJsonDoctorList(List<dynamic> json) {
    _doctorList = json
        .map((e) => Doctor(
              id: e["id"].toString(),
              nama: e["nama"],
              polyId: e["polyId"].toString(),
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
        polyId: json["polyId"].toString(),
        pengalaman: json["pengalaman"],
        foto: json["foto"],
      );
    // print("SEBELUM NOTIFY");
    notifyListeners();
    // print("DALAM SETJSON");
    // print(_doctor);
    return _doctor;
  }

  Future<List<Doctor>> fetchDataAllDoctor(String accessToken) async {
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

  Future<Doctor> fetchDataDoctorById(String doctor_id, String accessToken) async {
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
  Future<List<Doctor>> fetchDataDoctorByPolyId(String polyId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/doctor_poly_id/$polyId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      return setFromJsonDoctorList(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<RelasiRsPoliDoctor>> fetchAllRelasiRsPoliDoctor(String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/relasi_dokter_rs_poli/'),
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

  Future<RelasiRsPoliDoctor> fetchRelasiRsPoliDoctorByIdId(String relasiRsPoliId, String doctor_id, String accessToken) async {
    // print("diaats RESPONSE");
    final response = await http.get(
      Uri.parse('$url/relasi_dokter_rs_poli_id_id/$relasiRsPoliId/$doctor_id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    // print("DIBAWAGH RESPONSE");
    // print(inspect(response));
    if (response.statusCode == 200) {
      return RelasiRsPoliDoctor.fromJson(jsonDecode(response.body));
    } 
    else {
      return RelasiRsPoliDoctor(doctorId: '0', relasiRsPoliId: '0', id: '0', harga: 0);
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

  Future<DoctorSchedule> updateDoctorSchedule(String doctorScheduleId, DoctorSchedule doctorSchedule, String accessToken) async {
    print("SEBELUM PUT");
    // print("INI ARGUMEN");
    // print(inspect(doctorSchedule));
    // print("INI JSONENCODE");
    // print(jsonEncode({
    //     "tanggal": doctorSchedule.tanggal,
    //     "mulai": doctorSchedule.mulai,
    //     "selesai": doctorSchedule.selesai,
    //     "maxBooking": doctorSchedule.maxBooking,
    //     "currentBooking": doctorSchedule.currentBooking + 1,
    //     "doctorId": int.parse(doctorSchedule.doctorId),
    //   }));
    final response = await http.put(
      Uri.parse('$url/doctor_schedule/$doctorScheduleId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "tanggal": doctorSchedule.tanggal,
        "mulai": doctorSchedule.mulai,
        "selesai": doctorSchedule.selesai,
        "maxBooking": doctorSchedule.maxBooking,
        "currentBooking": doctorSchedule.currentBooking + 1,
        "doctorId": int.parse(doctorSchedule.doctorId),
      })
    );
    print("SETELAH PUT");
    if (response.statusCode == 200) {
      // print(inspect(DoctorSchedule.fromJson(jsonDecode(response.body))));
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
