class Comment {
  final String id;
  final String user;
  final String? userImage;
  final String? userId;
  final int? countLikes;
  final int? countDislikes;
  final Answer? answer;
  final String body;
  final bool? userLiked;
  final bool? userDisliked;
  final DateTime date;

  Comment({
    required this.id,
    required this.user,
    required this.body,
    required this.date,
    this.countLikes,
    this.userImage,
    this.userId,
    this.answer,
    this.countDislikes,
    this.userLiked,
    this.userDisliked,
  });
}

class Answer {
  final String id;
  final String trainerName;
  final String trainerImage;
  final String trainerId;
  final String body;
  final DateTime date;

  Answer({
    required this.id,
    required this.trainerId,
    required this.trainerName,
    required this.trainerImage,
    required this.body,
    required this.date,
  });
}
