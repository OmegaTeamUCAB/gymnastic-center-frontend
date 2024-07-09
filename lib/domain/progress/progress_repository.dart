import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/progress/progress.dart';

class UpdateProgressDTO {
  final String courseId;
  final String lessonId;
  final bool markAsCompleted;
  final int time;
  final int totalTime;

  UpdateProgressDTO(
      {required this.courseId,
      required this.lessonId,
      required this.markAsCompleted,
      required this.time,
      required this.totalTime});
}

class WatchingProgressDTO {
  final int page;
  final int perPage;
  WatchingProgressDTO({
    required this.page,
    this.perPage = 15,
  });
}

abstract class IProgressRepository {
  Future<Result<String>> startCourseProgress(String courseId);
  Future<Result<String>> updateCourseProgress(UpdateProgressDTO dto);
  Future<Result<Progress>> getCourseProgressById(String courseId);
  Future<Result<List<CourseProgress>>> getWatchingCourses(
      WatchingProgressDTO dto);
}
