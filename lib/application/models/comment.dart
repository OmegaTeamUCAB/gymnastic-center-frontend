
class Comment {
  final String id;
  final String userId;
  final String blogId;
  final String content;
  final DateTime postedAt;
   bool isExpanded;

  Comment({
    required this.id,
    required this.userId,
    required this.blogId,
    required this.content,
    required this.postedAt,
    this.isExpanded = false,
  });
}