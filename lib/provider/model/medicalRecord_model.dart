class MedicalRecord {
  final int id;
  final int patientId;
  final String waktu;
  final String formattedTime;
  final String jenisTes;
  final String hasilTes;

  MedicalRecord({
  required this.id,
  required this.patientId,
  required this.waktu,
  required this.formattedTime,
  required this.jenisTes,
  required this.hasilTes,
  }); 
}