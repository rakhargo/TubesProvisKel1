import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/provider/model/profile_model.dart';

class ProfileAPI with ChangeNotifier {
  final String url = 'http://127.0.0.1:8000';
  List<dynamic> _profileList = [];
  List<dynamic> get profileList => _profileList;

  Profile _profile = Profile
  (
    id: "",
    userId: "",
    nama: "",
    tanggalLahir: "",
    jenisKelamin: "",
    email: "",
    alamat: "",
    noTelepon: "",
    userPhoto: "",
  );
  Profile get profile => _profile;

  List<dynamic> setFromJsonList(List<dynamic> json) {
    _profileList = json
        .map((e) => Profile(
              id: e['id'].toString(),
              // id: e['id'],
              userId: e['userId'].toString(),
              nama: e['nama'],
              tanggalLahir: e['tanggalLahir'],
              jenisKelamin: e['jenisKelamin'],
              email: e['email'],
              alamat: e['alamat'],
              noTelepon: e['noTelepon'],
              userPhoto: e['userPhoto'],
            ))
        .toList();
    notifyListeners();

    return _profileList;
  }

  Profile setFromJson(Map<String, dynamic> json) {
    _profile = 
      Profile(
        id: json['id'].toString(),
        userId: json['userId'].toString(),
        nama: json['nama'],
        tanggalLahir: json['tanggalLahir'],
        jenisKelamin: json['jenisKelamin'],
        email: json['email'],
        alamat: json['alamat'],
        noTelepon: json['noTelepon'],
        userPhoto: json['userPhoto'],
      )
    ;
    notifyListeners();

    return _profile;
  }

  Future<List> fetchDataByUserId(String user_id, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/profile_user_id/$user_id'),
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

  Future<dynamic> fetchDataByProfileId(String profile_id, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/profile/$profile_id'),
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

  Future<http.Response> fetchImage(String profile_id, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/profile_picture/$profile_id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    // print("DATA IMAGE" + response.statusCode);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<bool> createNewProfile() async {
    try {
      // Your logic to create a new profile goes here
      // For example, you might send a request to your backend API
      // and wait for the response to determine if the profile was created successfully

      // For demonstration purposes, let's assume the profile creation is successful
      return true;
    } catch (e) {
      print('Error creating new profile: $e');
      return false;
    }
  }
}
