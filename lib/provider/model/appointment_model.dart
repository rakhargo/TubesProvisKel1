class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final String facilityId;

  final String status;
  final String waktu;
  final String formattedTime;
  final String metodePembayaran;

  Appointment({
  required this.id,
  required this.patientId,
  required this.doctorId,
  required this.facilityId,
  required this.status,
  required this.waktu,
  required this.formattedTime,
  required this.metodePembayaran,
  }); 
}