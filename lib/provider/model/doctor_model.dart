class Doctor {
  final String id;
  final String nama;
  final String polyId;
  final int pengalaman;
  final String foto;

  Doctor({
  required this.id,
  required this.nama,
  required this.polyId,
  required this.pengalaman,
  required this.foto,
  }); 
}

class DoctorSchedule 
{
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
    required this.doctorId,
    });

  factory DoctorSchedule.fromJson(Map<String, dynamic> json) {
    return DoctorSchedule(
      id: json['id'].toString(),
      tanggal: json['tanggal'],
      mulai: json['mulai'],
      selesai: json['selesai'],
      maxBooking: json['maxBooking'],
      currentBooking: json['currentBooking'],
      doctorId: json['doctorId'].toString(),
    );
  }
}

class RelasiRsPoliDoctor 
{
  final String doctorId;
  final String relasiRsPoliId;
  final String id;
  final int harga;

  RelasiRsPoliDoctor({
    required this.doctorId, 
    required this.relasiRsPoliId, 
    required this.id,
    required this.harga,
    });

  factory RelasiRsPoliDoctor.fromJson(Map<String, dynamic> json) {
    return RelasiRsPoliDoctor(
      doctorId: json['doctorId'].toString(),
      relasiRsPoliId: json['relasiRsPoliId'].toString(),
      id: json['id'].toString(),
      harga: json['harga'],
    );
  }
}