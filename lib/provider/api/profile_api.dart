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
    isMainProfile: "",
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
              isMainProfile: e['isMainProfile'].toString(),
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
        isMainProfile: json['isMainProfile'].toString(),
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

  Future<http.Response> createNewProfile(String userId, String nama, String tanggalLahir,  String jenisKelamin, String alamat, String email, String noTelepon, String userPhoto, String isMainProfile, String accessToken) async {
    final response = await http.post(
      Uri.parse('$url/create_profile/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(<String, dynamic>{
          'userId': userId, // Add userId field
          'nama': nama,
          'tanggalLahir': tanggalLahir,
          'jenisKelamin': jenisKelamin,
          'alamat': alamat,
          'email': email,
          'noTelepon': noTelepon,
          'userPhoto': userPhoto,
          'isMainProfile': isMainProfile,
      }),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<http.Response> fetchRelations (String accessToken) async{
    
    final response = await http.get(
      Uri.parse('$url/profile_relation/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<http.Response> updateProfile(Map<String, dynamic> profileUpdate, String accessToken, String profileId) async {
      final response = await http.put(
        Uri.parse('$url/update_profile/$profileId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(profileUpdate),
      );

      if (response.statusCode == 200) {
        // Profile updated successfully
        return response;
      } else {
        throw Exception(response.reasonPhrase);
      }
  }
}
