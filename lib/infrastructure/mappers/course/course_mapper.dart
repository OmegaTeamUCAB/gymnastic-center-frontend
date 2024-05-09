import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/infrastructure/mappers/lesson/lesson_mapper.dart';

class CourseMapper {
  static Course fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        level: json["level"],
        tags: (json["tags"] != null)
            ? List<String>.from(json["tags"].map((x) => x))
            : [],
        weeks: json["weeks"],
        minutes: json["minutes"],
        imageUrl: json["imageUrl"],
        categoryId: json["categoryId"],
        instructorId: json["instructorId"],
        lessons: LessonMapper.fromJsonToList(json["lessons"]),
        createdAt: (json["createdAt"] != null) ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: (json["updatedAt"] != null) ? DateTime.parse(json["updatedAt"]) : null,
      );

  static Map<String, dynamic> toJson(Course course) => {
        "id": course.id,
        "name": course.name,
        "description": course.description,
        "level": course.level,
        "tags": List<dynamic>.from(course.tags.map((x) => x)),
        "weeks": course.weeks,
        "minutes": course.minutes,
        "imageUrl": course.imageUrl,
        "categoryId": course.categoryId,
        "instructorId": course.instructorId,
        "lessons": List<dynamic>.from(
            course.lessons.map((x) => LessonMapper.toJson(x))),
      };
  static List<Course> fromJsonToList(dynamic jsonList) {
    return jsonList.map<Course>((json) => fromJson(json)).toList();
  }
}
