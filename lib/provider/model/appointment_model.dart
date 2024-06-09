class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final String facilityId;
  final String status;
  final String waktu;
  final String metodePembayaran;
  final int antrian;
  final String judul;

  Appointment({
  required this.id,
  required this.patientId,
  required this.doctorId,
  required this.facilityId,
  required this.status,
  required this.waktu,
  required this.metodePembayaran,
  required this.antrian,
  required this.judul
  }); 

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      facilityId: json['facilityId'],
      status: json['status'],
      waktu: json['waktu'],
      metodePembayaran: json['metodePembayaran'],
      antrian: json['antrian'],
      id: json['id'],
      judul: json['judul'],
    );
  }
}

class MedicalRecord {
  final String id;
  final String patientId;
  final String date;
  final String jenisTes;
  final String hasilTes;
  final String appointmentId;
  

  MedicalRecord({
  required this.id,
  required this.patientId,
  required this.date,
  required this.jenisTes,
  required this.hasilTes,
  required this.appointmentId,
  }); 

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['id'],
      patientId: json['patientId'],
      date: json['date'],
      jenisTes: json['jenisTes'],
      hasilTes: json['hasilTes'],
      appointmentId: json['appointmentId'],
    );
  }
}