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
  final String categoryId;
  final dynamic trainer;
  final List<Lesson>? lessons;
  final dynamic createdAt;
  final DateTime? updatedAt;

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
    required this.categoryId,
    this.lessons,
    this.createdAt,
    this.updatedAt,
  });
}

class Trainer {
  final String id;
  final String name;

  Trainer({
    required this.id,
    required this.name,
  });
}
