import 'package:gymnastic_center/domain/lesson/lesson.dart';

class Course {
  final String id;
  final String name;
  final String? description;
  final int? level;
  final dynamic tags;
  final int? weeks;
  final int? minutes;
  final String imageUrl;
  final String category;
  final dynamic trainer;
  final List<Lesson>? lessons;
  final dynamic createdAt;
  final DateTime? updatedAt;
  final int? percent; 

  Course({
    required this.id,
    required this.name,
    this.description,
    this.level,
    this.tags,
    this.weeks,
    this.minutes,
    required this.imageUrl,
    required this.trainer,
    required this.category,
    this.lessons,
    this.createdAt,
    this.updatedAt,
    this.percent,
  });
}
