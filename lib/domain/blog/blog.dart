class Blog {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final String content;
  final DateTime uploadDate;
  final dynamic comments;

  Blog({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.content,
    required this.comments,
    required this.uploadDate,
  });
}
