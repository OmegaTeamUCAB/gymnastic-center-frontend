import 'package:gymnastic_center/domain/lesson/lesson.dart';

class Course {
  final String id;
  final String name;
  final String description;
  final int level;
  final List<String> tags;
  final int weeks;
  final int minutes;
  final String imageUrl;
  final String categoryId;
  final Trainer trainer;
  final List<Lesson> lessons;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.level,
    required this.tags,
    required this.weeks,
    required this.minutes,
    required this.imageUrl,
    required this.trainer,
    required this.categoryId,
    required this.lessons,
    required this.createdAt,
    required this.updatedAt,
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
