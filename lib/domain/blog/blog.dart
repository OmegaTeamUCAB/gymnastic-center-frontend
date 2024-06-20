class Blog {
  final String id;
  final List<dynamic> images;
  final String? description;
  final String title;
  final dynamic trainer;
  final String? content;
  final dynamic tags;
  final String? uploadDate;
  final String? category;
  final int? comments;

  Blog({
    required this.id,
    required this.images,
    required this.title,
    this.content,
    this.description,
    this.trainer,
    this.tags,
    this.uploadDate,
    this.category,
    this.comments,
  });
}
