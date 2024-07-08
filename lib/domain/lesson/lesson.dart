import 'package:gymnastic_center/domain/comment/comment.dart';

class Lesson {
  final String id;
  final String title;
  final String? content;
  final String? videoUrl;
  final String? imageUrl;
  final List<Comment> comments;
  final int? time;
  final int? percent;

  const Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.videoUrl,
    required this.imageUrl,
    required this.comments,
    required this.time,
    required this.percent,
  });
}
