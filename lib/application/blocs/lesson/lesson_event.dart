part of 'lesson_bloc.dart';

@immutable
sealed class LessonEvent {}

class LoadLessons extends LessonEvent {
  final List<Lesson> lessons;

  LoadLessons({required this.lessons});

}
class ChangeToNextLesson extends LessonEvent {}
class ChangeToPreviousLesson extends LessonEvent {}
class ChangeLessonById extends LessonEvent {
  final String lessonId;

  ChangeLessonById({required this.lessonId});
}
class ChangeToFirstLesson extends LessonEvent {}

