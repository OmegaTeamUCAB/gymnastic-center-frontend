import 'package:gymnastic_center/domain/comment/comment.dart';

class CommentMapper {
  static Comment fromJson(Map<String, dynamic> json) => Comment(
        userId: json["userId"],
        blogId: json["blogId"],
        content: json["content"],
        postedAt: DateTime.parse(json["postedAt"]),
      );

  static Map<String, dynamic> toJson(Comment comment) => {
        "userId": comment.userId,
        "blogId": comment.blogId,
        "content": comment.content,
        "postedAt": comment.postedAt.toIso8601String(),
      };
  static List<Comment> fromJsonToList(dynamic jsonList) {
    return jsonList.map<Comment>((json) => fromJson(json)).toList();
  }
}
