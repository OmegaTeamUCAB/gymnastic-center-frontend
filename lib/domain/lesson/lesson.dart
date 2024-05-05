import 'package:gymnastic_center/domain/comment/comment.dart';

class Lesson {
    final String id;
    final String title;
    final String description;
    final String? content;
    final String? videoUrl;
    final String? imageUrl;
    final List<Comment> comments;

    Lesson({
        required this.id,
        required this.title,
        required this.description,
        required this.content,
        required this.videoUrl,
        required this.imageUrl,
        required this.comments,
    });
}