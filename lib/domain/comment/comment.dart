class Comment {
  final String id;
  final String user;
  final String? userImage;
  final String? userId;
  final int countLikes;
  final int countDislikes;
  final Answer? answer;
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
    this.answer,
    this.countDislikes = 0,
    required this.userLiked,
    required this.userDisliked,
  });
}

class Answer {
  final String id;
  final String trainer;
  final String? trainerImage;
  final String body;
  final DateTime date;

  Answer({
    required this.id,
    required this.trainer,
    this.trainerImage,
    required this.body,
    required this.date,
  });
}
