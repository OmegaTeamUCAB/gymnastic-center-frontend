class Comment {
  final String id;
  final String user;
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
    this.countDislikes = 0,
    this.userLiked = false,
    this.userDisliked = false,
  });
}
