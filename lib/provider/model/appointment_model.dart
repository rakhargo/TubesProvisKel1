class Appointment {
  final int id;
  final int patientId;
  final int doctorId;
  final int facilityId;
  final String status;
  final String waktu;
  final String formattedTime;

  Appointment({
  required this.id,
  required this.patientId,
  required this.doctorId,
  required this.facilityId,
  required this.status,
  required this.waktu,
  required this.formattedTime,
  }); 
}