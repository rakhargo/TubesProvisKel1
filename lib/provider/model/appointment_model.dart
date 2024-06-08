class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final String facilityId;
  final String status;
  final String waktu;
  final String metodePembayaran;
  final String medicalRecordId;
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
  required this.medicalRecordId,
  required this.antrian,
  required this.judul
  }); 
}