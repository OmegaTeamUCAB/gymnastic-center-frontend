part of 'progress_bloc.dart';

@immutable
sealed class ProgressEvent {}
class StartCourse extends ProgressEvent {
  final String courseId;
  StartCourse({
    required this.courseId,
  });

}
class LessonProgressRequested extends ProgressEvent {
  final String courseId;
  LessonProgressRequested({
    required this.courseId
  });
}

class ProgressLessonUpdated extends ProgressEvent {
  final String courseId;
  final String lessonId;
  final bool markAsCompleted;
  final Duration time;
  final Duration totalTime;
  ProgressLessonUpdated({
    required this.courseId,
    required this.lessonId,
    required this.markAsCompleted,
    required this.time,
    required this.totalTime
  });

}

