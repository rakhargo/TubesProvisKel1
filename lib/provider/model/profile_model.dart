class Profile {
  final String id;
  final String userId;

  final String nama;
  final String tanggalLahir;
  final String jenisKelamin;
  final String alamat;
  final String noTelepon;
  final String email;
  final String userPhoto;
  final String isMainProfile;

  Profile({
  required this.id,
  required this.userId,
  required this.nama,
  required this.tanggalLahir,
  required this.jenisKelamin,
  required this.alamat,
  required this.noTelepon,
  required this.email,
  required this.userPhoto,
  required this.isMainProfile
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'nama': nama,
      'tanggalLahir': tanggalLahir,
      'jenisKelamin': jenisKelamin,
      'email': email,
      'alamat': alamat,
      'noTelepon': noTelepon,
      'userPhoto': userPhoto,
      'isMainProfile': isMainProfile,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      userId: json['userId'],
      nama: json['nama'],
      tanggalLahir: json['tanggalLahir'],
      jenisKelamin: json['jenisKelamin'],
      email: json['email'],
      alamat: json['alamat'],
      noTelepon: json['noTelepon'],
      userPhoto: json['userPhoto'],
      isMainProfile: json['isMainProfile'],
    );
  }
}

class ProfileRelation {
  final String id;
  final String relation;

  ProfileRelation({
    required this.id,
    required this.relation,
  });

  factory ProfileRelation.fromJson(Map<String, dynamic> json) {
    return ProfileRelation(
      id: json['id'].toString(),
      relation: json['relation'].toString(),
    );
  }
}