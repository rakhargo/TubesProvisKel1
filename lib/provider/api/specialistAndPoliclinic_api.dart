import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import '/provider/model/specialistAndPolyclinic_model.dart';

class SpecialistAndPolyclinicAPI with ChangeNotifier {
  final String url = 'http://127.0.0.1:8000';
  List<dynamic> _specialistAndPoliclinicList = [];
  List<dynamic> get specialistAndPoliclinicList => _specialistAndPoliclinicList;

  SpecialistAndPolyclinic _specialistAndPoliclinic = SpecialistAndPolyclinic
  (
    id: "",
    icon: "",
    name: "",
  );
  SpecialistAndPolyclinic get doctor => _specialistAndPoliclinic;

  List<dynamic> setFromJsonList(List<dynamic> json) {
    _specialistAndPoliclinicList = json
        .map((e) => SpecialistAndPolyclinic(
              id: e['id'].toString(),
              // id: e['id'],
              icon: e['icon'],
              name: e['name'],
            ))
        .toList();
    notifyListeners();

    return _specialistAndPoliclinicList;
  }

  SpecialistAndPolyclinic setFromJsonPoli(Map<String, dynamic> json) {
    _specialistAndPoliclinic = 
      SpecialistAndPolyclinic(
        id: json["id"].toString(),
        icon: json["icon"],
        name: json["name"],
      )
    ;
    notifyListeners();

    return _specialistAndPoliclinic;
  }

  Future<List<JudulPoli>> fetchRelasiJudulPoliByPoliId(String poliId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/relasi_judul_poli_id/$poliId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<JudulPoli> relasiJudulList = data.map((e) => JudulPoli.fromJson(e)).toList();
      // print("INI LIST RELASI");
      print(inspect(relasiJudulList));
      return relasiJudulList;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<JudulPoli>> fetchAllJudulPoli(String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/relasi_judul_poli/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<JudulPoli> judulPoliList = data.map((e) => JudulPoli.fromJson(e)).toList();
      return judulPoliList;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<JudulPoli> fetchJudulPoliById(String relasiJudulPoliId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/relasi_judul_poli/$relasiJudulPoliId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      return JudulPoli.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List> fetchData(String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/specialist_and_polyclinic/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      return setFromJsonList(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
  
  Future<dynamic> fetchDataById(String poliId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/specialist_and_polyclinic/$poliId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      return setFromJsonPoli(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<http.Response> fetchImage(String specialistAndPolyclinic_id, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/specialist_and_polyclinic_images/$specialistAndPolyclinic_id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
