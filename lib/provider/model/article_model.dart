class HealthArticle {
  final int id;
  final String title;
  final String content;
  final String coverImage;
  final String topics;
  final int recommendedDoctor;
  final String references;

  HealthArticle({
  required this.id,
  required this.title,
  required this.content,
  required this.coverImage,
  required this.topics,
  required this.recommendedDoctor,
  required this.references,
  }); 
}