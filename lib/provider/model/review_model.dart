class Review {
  final String id;
  final String reviewerId;
  final String revieweeDoctorId;
  final String revieweeFaskesId;
  final String rating;
  final String komentar;
  final String tanggal;

  Review({
    required this.id,
    required this.reviewerId,
    required this.revieweeDoctorId,
    required this.revieweeFaskesId,
    required this.rating,
    required this.komentar,
    required this.tanggal
  });
}