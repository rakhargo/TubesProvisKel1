class Polyclinic {
  final String id;
  final String icon;
  final String name;

  Polyclinic ({
    required this.id,
    required this.icon,
    required this.name
  });
}

class RelasiJudulPoli {
  final String id;
  final String judul;
  final String polyclinicId;

  RelasiJudulPoli ({
    required this.id,
    required this.judul,
    required this.polyclinicId
  });

  factory RelasiJudulPoli.fromJson(Map<String, dynamic> json) {
    return RelasiJudulPoli(
      id: json['id'].toString(),
      judul: json['judul'].toString(),
      polyclinicId: json['polyclinicId'].toString()
    );
  }
}