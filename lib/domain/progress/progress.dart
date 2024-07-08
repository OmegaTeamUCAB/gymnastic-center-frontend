import 'package:gymnastic_center/domain/course/course.dart';

class Progress{
  final List<LessonProgress> lessonProgress;
  final double percent;
  const Progress({
    required this.lessonProgress,
    required this.percent,
  });
}

class LessonProgress {
  final String lessonId;
  final int time;
  final double percent;

  LessonProgress({
    required this.lessonId,
    required this.time,
    required this.percent,
  });
}

class CourseProgress {
  final Course course;
  final double percent;
  CourseProgress({
    required this.course,
    required this.percent
  });
}