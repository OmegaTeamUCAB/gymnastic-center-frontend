import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/progress/get_course_progess.use_case.dart';
import 'package:gymnastic_center/application/use_cases/progress/start_course_progess.use_case.dart';
import 'package:gymnastic_center/application/use_cases/progress/update_course_progess.use_case.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';
import 'package:gymnastic_center/domain/progress/progress.dart';
import 'package:meta/meta.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(const LessonState()) {
    on<ChangeToNextLesson>(_changeToNextLesson);
    on<ChangeToPreviousLesson>(_changeToPreviousLesson);
    on<ChangeToFirstLesson>(_changeToFirstLesson);
    on<ChangeLessonById>(_changeLessonById);
    on<LoadCourseInfo>(_loadCourseInfo);
    on<LoadCourseInfo>(_loadCourseInfo);
  }

  Future<void> _changeToFirstLesson(
      ChangeToFirstLesson event, Emitter<LessonState> emit) async {
    emit(state.copyWith(lessonStatus: LessonStatus.changing));
    final lesson = state.courseLessons.first;
    emit(state.copyWith(
        firstLesson: state.courseLessons.first.id == lesson.id,
        lastLesson: state.courseLessons.last.id == lesson.id,
        lesson: lesson,
        lessonStatus: LessonStatus.loaded));
  }

  void _changeLessonById(ChangeLessonById event, Emitter<LessonState> emit) {
    emit(state.copyWith(lessonStatus: LessonStatus.changing));
    final lesson = state.courseLessons
        .where((element) => element.id == event.lessonId)
        .toList()[0];
    emit(state.copyWith(
        firstLesson: state.courseLessons.first.id == lesson.id,
        lastLesson: state.courseLessons.last.id == lesson.id,
        lesson: lesson,
        lessonStatus: LessonStatus.loaded));
  }

  void _loadCourseInfo(LoadCourseInfo event, Emitter<LessonState> emit) {
    emit(state.copyWith(lessonStatus: LessonStatus.loading));
    final lessons = event.lessons;
    emit(state.copyWith(
        lessonStatus: LessonStatus.loaded,
        courseLessons: event.lessons,
        firstLesson: lessons.first.id == lessons.first.id,
        lastLesson: lessons.first.id == lessons.last.id,
        lesson: lessons.first,
        courseImage: event.courseImage,
        courseId: event.course));
  }

  void _changeToNextLesson(
      ChangeToNextLesson event, Emitter<LessonState> emit) {
    if (state.lastLesson == true) return;
    emit(state.copyWith(lessonStatus: LessonStatus.loading));
    final nextLesson =
        state.courseLessons[state.courseLessons.indexOf(state.lesson) + 1];
    emit(state.copyWith(
        firstLesson: state.courseLessons.first.id == nextLesson.id,
        lastLesson: state.courseLessons.last.id == nextLesson.id,
        lesson: nextLesson,
        lessonStatus: LessonStatus.loaded));
  }

  void changeToNextLesson() {
    add(ChangeToNextLesson());
  }

  void _changeToPreviousLesson(
      ChangeToPreviousLesson event, Emitter<LessonState> emit) {
    if (state.firstLesson == true) return;
    emit(state.copyWith(lessonStatus: LessonStatus.loading));
    final previousLesson =
        state.courseLessons[state.courseLessons.indexOf(state.lesson) - 1];
    emit(state.copyWith(
        firstLesson: state.courseLessons.first.id == previousLesson.id,
        lastLesson: state.courseLessons.last.id == previousLesson.id,
        lesson: previousLesson,
        lessonStatus: LessonStatus.loaded));
  }

  void changeToPreviousLesson() {
    add(ChangeToPreviousLesson());
  }

  LessonProgress? getCurrentLessonProgress() {
    if (state.progress.lessonProgress.isEmpty) return null;
    return state.progress.lessonProgress
        .where((element) => element.lessonId == state.lesson.id)
        .toList()[0];
  }

  Lesson getNextLesson() {
    int numberToAdd = 1;
    if (state.lastLesson == true) numberToAdd = 0;
    return state
        .courseLessons[state.courseLessons.indexOf(state.lesson) + numberToAdd];
  }
}
