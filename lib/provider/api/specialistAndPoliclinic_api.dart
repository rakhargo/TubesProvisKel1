import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/provider/model/specialistAndPolyclinic_model.dart';

class SpecialistAndPolyclinicList with ChangeNotifier {
  final String url = 'http://127.0.0.1:8000'; 
  List<dynamic> _specialistAndPoliclinicList = [];
  List<dynamic> get specialistAndPoliclinicList => _specialistAndPoliclinicList;

  List<dynamic> setFromJson(List<dynamic> json) {
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

  Future<List> fetchData() async {
    final response = await http.get(Uri.parse('$url/specialist_and_polyclinic'),
    // final response = await http.get(Uri.parse('$url/specialist_and_polyclinic'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': token,
      },
    );
    print(response.headers);
    if (response.statusCode == 200) {
      return setFromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<http.Response> fetchImage(String specialistAndPolyclinic_id) async {
    final response = await http.get(
      Uri.parse('$url/specialist_and_polyclinic_images/$specialistAndPolyclinic_id'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}