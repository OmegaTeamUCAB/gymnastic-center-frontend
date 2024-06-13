import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';
import 'package:meta/meta.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(LessonLoading()) {
    on<ChangeToNextLesson>(_changeToNextLesson);
    on<ChangeToPreviousLesson>(_changeToPreviousLesson);
    on<ChangeToFirstLesson>(_changeToFirstLesson);
    on<ChangeLessonById>(_changeLessonById);
    on<LoadLessons>(_loadLessons);
  }

  Future<void> _changeToFirstLesson(ChangeToFirstLesson event, Emitter<LessonState> emit) async {
    emit(LessonChanging(courseLessons: state.courseLessons, firstLesson: state.firstLesson, lastLesson: state.lastLesson, lesson: state.lesson));
    final lesson = state.courseLessons.first; 
    emit(LessonLoaded(courseLessons: state.courseLessons, firstLesson: state.courseLessons.first.id == lesson.id, lastLesson: state.courseLessons.last.id == lesson.id, lesson: lesson));
  }

    void _changeLessonById(ChangeLessonById event, Emitter<LessonState> emit) async {
    emit(LessonChanging(courseLessons: state.courseLessons, firstLesson: state.firstLesson, lastLesson: state.lastLesson, lesson: state.lesson));
    final lesson = state.courseLessons.where((element) => element.id == event.lessonId).toList()[0];
    emit(LessonLoaded(courseLessons: state.courseLessons, firstLesson: state.courseLessons.first.id == lesson.id, lastLesson: state.courseLessons.last.id == lesson.id, lesson: lesson));
  }

  Future<void> _loadLessons(LoadLessons event, Emitter<LessonState> emit) async {
    emit(LessonLoading());
    emit(LessonLoaded(courseLessons: event.lessons, firstLesson: state.firstLesson, lastLesson: state.lastLesson, lesson: state.lesson));
  }

  void _changeToNextLesson(ChangeToNextLesson event, Emitter<LessonState> emit) {
    if(state.lastLesson == true) return;
    emit(LessonChanging(courseLessons: state.courseLessons, firstLesson: state.firstLesson, lastLesson: state.lastLesson, lesson: state.lesson));
    final nextLesson = state.courseLessons[state.courseLessons.indexOf(state.lesson) + 1];
    emit(LessonLoaded(courseLessons: state.courseLessons, firstLesson: state.courseLessons.first.id == nextLesson.id, lastLesson: state.courseLessons.last.id == nextLesson.id, lesson: nextLesson));
  }

  void changeToNextLesson(){
    add(ChangeToNextLesson());
  }
  
  void _changeToPreviousLesson(ChangeToPreviousLesson event, Emitter<LessonState> emit) {
    if(state.firstLesson == true) return;
    emit(LessonChanging(courseLessons: state.courseLessons, firstLesson: state.firstLesson, lastLesson: state.lastLesson, lesson: state.lesson));
    final previousLesson = state.courseLessons[state.courseLessons.indexOf(state.lesson) - 1];
    emit(LessonLoaded(courseLessons: state.courseLessons, firstLesson: state.courseLessons.first.id == previousLesson.id, lastLesson: state.courseLessons.last.id == previousLesson.id, lesson: previousLesson));
  }
  
  void changeToPreviousLesson(){
    add(ChangeToPreviousLesson());
  }

  Lesson getNextLesson() {
    int numberToAdd = 1;
    if (state.lastLesson == true) numberToAdd = 0;
    return state.courseLessons[state.courseLessons.indexOf(state.lesson) + numberToAdd];
  }

}
