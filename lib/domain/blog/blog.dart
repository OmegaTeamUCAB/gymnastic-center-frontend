class Blog {
  final String id;
  final List<dynamic> images;
  final String title;
  final dynamic trainer;
  final String? content;
  final List<dynamic>? tags;
  final String? uploadDate;
  final String? category;

  Blog({
    required this.id,
    required this.images,
    required this.title,
    this.content,
    this.trainer,
    this.tags,
    this.uploadDate,
    this.category,
  });
}
