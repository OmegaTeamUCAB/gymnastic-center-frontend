class Blog {
  final String id;
  final List<dynamic> images;
  final String title;
  final String? description;
  final dynamic trainer;
  final String? content;
  final List<dynamic>? tags;
  final String uploadDate;

  Blog({
    required this.id,
    required this.images,
    required this.title,
    this.description,
    this.content,
    required this.trainer,
    this.tags,
    required this.uploadDate,
  });
}
