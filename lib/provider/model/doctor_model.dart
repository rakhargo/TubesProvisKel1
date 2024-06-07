class Doctor {
  final String id;
  final String nama;
  final String spesialisasi;
  final String pengalaman;
  final String foto;

  Doctor({
  required this.id,
  required this.nama,
  required this.spesialisasi,
  required this.pengalaman,
  required this.foto,
  }); 
}

class RelasiRsPoliDoctor 
{
  final String doctorId;
  final String relasiRsPoliId;
  final String id;

  RelasiRsPoliDoctor({
    required this.doctorId, 
    required this.relasiRsPoliId, 
    required this.id,
    });

  factory RelasiRsPoliDoctor.fromJson(Map<String, dynamic> json) {
    return RelasiRsPoliDoctor(
      doctorId: json['doctorId'].toString(),
      relasiRsPoliId: json['relasiRsPoliId'].toString(),
      id: json['id'].toString(),
    );
  }
}