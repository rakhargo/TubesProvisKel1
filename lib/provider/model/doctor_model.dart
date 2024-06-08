class Doctor {
  final String id;
  final String nama;
  final String spesialisasi;
  final int pengalaman;
  final String foto;

  Doctor({
  required this.id,
  required this.nama,
  required this.spesialisasi,
  required this.pengalaman,
  required this.foto,
  }); 
}

class DoctorSchedule {
  final String id;
  final String tanggal;
  final String mulai;
  final String selesai;
  final int maxBooking;
  final int currentBooking;
  final String doctorId;

  DoctorSchedule({
    required this.id,
    required this.tanggal,
    required this.mulai,
    required this.selesai,
    required this.maxBooking,
    required this.currentBooking,
    required this.doctorId
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