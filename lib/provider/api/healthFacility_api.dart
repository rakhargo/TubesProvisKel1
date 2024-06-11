import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:medimate/provider/model/article_model.dart';
import '/provider/model/healthFacility_model.dart';
import '/provider/model/specialistAndPolyclinic_model.dart';
import '/provider/api/specialistAndPoliclinic_api.dart';

class HealthFacilityAPI with ChangeNotifier {
  final String url = 'http://127.0.0.1:8000';
  List<HealthFacility> _healthFacilityList = [];
  List<HealthFacility> get healthFacilityList => _healthFacilityList;

  HealthFacility _healthFacility = HealthFacility
  (
    id: "",
    namaFasilitas: "",
    alamatFasilitas: "",
    kecamatanFasilitas: "",
    kotaKabFasilitas: "",
    kodePosFasilitas: "",
    tingkatFasilitas: "",
    jumlahPoliklinik: "",
    daftarPoliklinik: "",
    fotoFaskes: "",
    logoFaskes: "",
  );
  HealthFacility get healthFacility => _healthFacility;

  List<HealthFacility> setFromJsonList(List<dynamic> json) {
    _healthFacilityList = json
        .map((e) => HealthFacility(
              id: e["id"].toString(),
              namaFasilitas: e["namaFasilitas"],
              alamatFasilitas: e["alamatFasilitas"],
              kecamatanFasilitas: e["kecamatanFasilitas"],
              kotaKabFasilitas: e["kotaKabFasilitas"],
              kodePosFasilitas: e["kodePosFasilitas"],
              tingkatFasilitas: e["tingkatFasilitas"],
              jumlahPoliklinik: e["jumlahPoliklinik"],
              daftarPoliklinik: e["daftarPoliklinik"],
              fotoFaskes: e["fotoFaskes"],
              logoFaskes: e["logoFaskes"],
            ))
        .toList();
    notifyListeners();

    return _healthFacilityList;
  }

  HealthFacility setFromJson(Map<String, dynamic> json) {
    _healthFacility = 
      HealthFacility(
        id: json["id"].toString(),
        namaFasilitas: json["namaFasilitas"],
        alamatFasilitas: json["alamatFasilitas"],
        kecamatanFasilitas: json["kecamatanFasilitas"],
        kotaKabFasilitas: json["kotaKabFasilitas"],
        kodePosFasilitas: json["kodePosFasilitas"],
        tingkatFasilitas: json["tingkatFasilitas"],
        jumlahPoliklinik: json["jumlahPoliklinik"],
        daftarPoliklinik: json["daftarPoliklinik"],
        fotoFaskes: json["fotoFaskes"],
        logoFaskes: json["logoFaskes"],
      )
    ;
    notifyListeners();

    return _healthFacility;
  }

  Future<List<HealthFacility>> fetchDataAll(String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/health_facility/'),
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

  Future<HealthFacility> fetchDataById(String health_facility_id, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/health_facility_id/$health_facility_id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    // print(response);
    // print("INI RESPONSE");
    // print(response);
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
      // print(response.body);
      return setFromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<RelasiRsPoli>> fetchRelasiRsPoliByPoliId(String poliId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/relasi_rs_poli_id/$poliId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<RelasiRsPoli> relasiList = data.map((e) => RelasiRsPoli.fromJson(e)).toList();
      // print("INI LIST RELASI");
      // print(relasiList);
      return relasiList;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<RelasiRsPoli>> fetchRelasiRsPoliByRsId(String rsId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/relasi_rs_poli_rs_id/$rsId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<RelasiRsPoli> relasiList = data.map((e) => RelasiRsPoli.fromJson(e)).toList();
      // print("INI LIST RELASI");
      // print(relasiList);
      return relasiList;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<http.Response> fetchImageFoto(String health_facility_id, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/health_facility_picture/$health_facility_id'),
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

  Future<http.Response> fetchImageLogo(String health_facility_id, String accessToken) async {
    final response = await http.get(
      Uri.parse('$url/health_facility_logo/$health_facility_id'),
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
}
