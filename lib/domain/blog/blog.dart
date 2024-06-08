class Blog {
  final String id;
  final List<String> images;
  final String title;
  final String description;
  final dynamic trainer;
  final String content;
  final DateTime uploadDate;

  Blog({
    required this.id,
    required this.images,
    required this.title,
    required this.description,
    required this.content,
    required this.trainer,
    required this.uploadDate,
  });
}
