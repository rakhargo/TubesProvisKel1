class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final String facilityId;
  final String status;
  final String waktu;
  final String metodePembayaran;
  final int antrian;
  final String relasiJudulPoliId;

  Appointment({
  required this.id,
  required this.patientId,
  required this.doctorId,
  required this.facilityId,
  required this.status,
  required this.waktu,
  required this.metodePembayaran,
  required this.antrian,
  required this.relasiJudulPoliId
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
      relasiJudulPoliId: json['relasiJudulPoliId'],
      id: json['id'],
    );
  }
}

class MedicalRecord {
  final String id;
  final String patientId;
  final String date;
  final String appointmentId;
  final String relasiJudulPoliId;
  

  MedicalRecord({
  required this.id,
  required this.patientId,
  required this.date,
  required this.appointmentId,
  required this.relasiJudulPoliId,
  }); 

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['id'].toString(),
      patientId: json['patientId'].toString(),
      date: json['date'],
      appointmentId: json['appointmentId'].toString(),
      relasiJudulPoliId: json['relasiJudulPoliId'].toString(),
    );
  }
}