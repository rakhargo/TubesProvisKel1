class Referral {
  final String id;
  final String fromFacilityId;
  final String toFacilityId;
  final String patientId;
  final String tanggal;
  final String alasan;

  Referral ({
    required this.id,
    required this.fromFacilityId,
    required this.toFacilityId,
    required this.patientId,
    required this.tanggal,
    required this.alasan,
  });
}