import 'package:gymnastic_center/domain/comment/comment.dart';

class CommentMapper {
static Comment fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        content: json["content"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

  static Map<String, dynamic> toJson(Comment comment) => {
        "id": comment.id,
        "content": comment.content,
        "userId": comment.userId,
        "createdAt": comment.createdAt.toIso8601String(),
    };
  
  static List<Comment> fromJsonToList(dynamic jsonList) {
    return jsonList.map<Comment>((json) => fromJson(json)).toList();
  }
}
