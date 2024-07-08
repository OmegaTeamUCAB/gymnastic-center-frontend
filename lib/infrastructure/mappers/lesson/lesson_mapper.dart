import 'package:gymnastic_center/domain/lesson/lesson.dart';
import 'package:gymnastic_center/infrastructure/mappers/comment/comment_mapper.dart';

class LessonMapper {
  static Lesson fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        title: json["title"],
        content: (json["content"] != null) ? json["content"] : null,
        videoUrl: (json["video"] != null) ? json["video"] : null,
        imageUrl: (json["image"] != null) ? json["image"] : null,
        comments: (json["comments"] != null)
            ? CommentMapper.fromJsonToList(json["comments"])
            : [],
        percent: (json["percent"] != null) ? json["percent"] : null,
        time: (json["time"] != null) ? json["time"] : null,
      );

  //! remove if unused
  static Map<String, dynamic> toJson(Lesson lesson) => {
        "id": lesson.id,
        "title": lesson.title,
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
