class Comment {
  final String id;
  final String user;
  final String? userImage;
  final String? userId;
  final int countLikes;
  final int countDislikes;
  final String body;
  final bool userLiked;
  final bool userDisliked;
  final DateTime date;

  Comment({
    required this.id,
    required this.user,
    required this.body,
    required this.date,
    this.countLikes = 0,
    this.userImage,
    this.userId,
    this.countDislikes = 0,
    required this.userLiked,
    required this.userDisliked,
  });
}

enum TargetType { BLOG, LESSON }
