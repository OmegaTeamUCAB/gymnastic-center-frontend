import 'package:gymnastic_center/domain/lesson/lesson.dart';
import 'package:gymnastic_center/infrastructure/mappers/comment/comment_mapper.dart';

class LessonMapper {
  static Lesson fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        content: (json["content"] != null) ? json["content"] : null,
        videoUrl: (json["videoUrl"] != null) ? json["videoUrl"] : null,
        imageUrl: (json["imageUrl"] != null) ? json["imageUrl"] : null,
        comments: (json["comments"] != null)
            ? CommentMapper.fromJsonToList(json["comments"])
            : [],
      );

  static Map<String, dynamic> toJson(Lesson lesson) => {
        "id": lesson.id,
        "title": lesson.title,
        "description": lesson.description,
        "content": lesson.content,
        "videoUrl": lesson.videoUrl,
        "imageUrl": lesson.imageUrl,
        "comments": List<dynamic>.from(
            lesson.comments.map((x) => CommentMapper.toJson(x))),
      };

  static List<Lesson> fromJsonToList(dynamic jsonList) {
    return jsonList.map<Lesson>((json) => fromJson(json)).toList();
  }
}
