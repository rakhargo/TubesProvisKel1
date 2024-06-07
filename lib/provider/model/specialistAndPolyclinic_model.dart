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