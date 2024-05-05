import 'package:gymnastic_center/domain/blog/blog.dart';

class BlogMapper {

   static Blog fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        imageUrl: json["imageUrl"],
        title: json["title"],
        description: json["description"],
        content: json["content"],
        uploadDate: DateTime.parse(json["uploadDate"]),
    );

    static Map<String, dynamic> toJson(Blog blog) => {
        "id": blog.id,
        "imageUrl": blog.imageUrl,
        "title": blog.title,
        "description": blog.description,
        "content": blog.content,
        "uploadDate": blog.uploadDate.toIso8601String(),
    };

    static List<Blog> fromJsonToList(dynamic jsonList) {
      return jsonList.map<Blog>((json) => fromJson(json)).toList();
  }
}