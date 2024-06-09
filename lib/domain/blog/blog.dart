class Blog {
  final String id;
  final List<String> images;
  final String title;
  final String? description;
  final dynamic trainer;
  final String? content;
  final String uploadDate;

  Blog({
    required this.id,
    required this.images,
    required this.title,
    this.description,
    this.content,
    required this.trainer,
    required this.uploadDate,
  });
}
