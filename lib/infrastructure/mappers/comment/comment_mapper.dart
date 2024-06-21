import 'package:gymnastic_center/domain/comment/comment.dart';

class CommentMapper {
  static Comment fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        user: json["user"],
        date: DateTime.parse(json["date"]),
      );

  static Map<String, dynamic> toJson(Comment comment) => {
        "id": comment.id,
        "body": comment.body,
        "user": comment.user,
        "date": comment.date.toIso8601String(),
      };

  static List<Comment> fromJsonToList(dynamic jsonList) {
    return jsonList.map<Comment>((json) => fromJson(json)).toList();
  }
}
