class SpecialistAndPolyclinic {
  final String id;
  final String icon;
  final String name;

  SpecialistAndPolyclinic({
  required this.id,
  required this.icon,
  required this.name,
  }); 

  factory SpecialistAndPolyclinic.fromJson(Map<String, dynamic> json) {
    return SpecialistAndPolyclinic(
      id: json['id'].toString(),
      icon: json['icon'],
      name: json['name'],
    );
  }
}

class JudulPoli {
  final String id;
  final String polyclinicId;
  final String judul;
  final String tindakan;

  JudulPoli({
  required this.id,
  required this.polyclinicId,
  required this.judul,
  required this.tindakan,
  }); 

  factory JudulPoli.fromJson(Map<String, dynamic> json) {
    return JudulPoli(
      id: json['id'].toString(),
      polyclinicId: json['polyclinicId'].toString(),
      judul: json['judul'],
      tindakan: json['tindakan'],
    );
  }
}