// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/progress/get_course_progess.use_case.dart';
import 'package:gymnastic_center/application/use_cases/progress/start_course_progess.use_case.dart';
import 'package:gymnastic_center/application/use_cases/progress/update_course_progess.use_case.dart';
import 'package:gymnastic_center/domain/progress/progress.dart';
import 'package:gymnastic_center/domain/progress/progress_repository.dart';
import 'package:meta/meta.dart';

part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final StartCourseProgressUseCase startCourseProgressUseCase;
  final GetCourseProgressByIdUseCase getCourseProgressByIdUseCase;
  final UpdateCourseProgressUseCase updateCourseProgressUseCase;
  
  ProgressBloc({
    required this.startCourseProgressUseCase,
    required this.getCourseProgressByIdUseCase,
    required this.updateCourseProgressUseCase
  }): super(ProgressState()) {
    on<LessonProgressRequested>(_loadLessonProgress);
    on<ProgressLessonUpdated>(_updateLessonProgress);
  }

  Future<void> startCourse(StartCourse event, String lessonId) async {
    final result = await startCourseProgressUseCase.execute(StartCourseByIdDto(event.courseId));
  }

  Future<void> updateAndLoadProgress(ProgressLessonUpdated event, String id) async {
    emit(state.copyWith(progressStatus: ProgressStatus.fetching)); 
    final result = await updateCourseProgressUseCase.execute(UpdateProgressDTO(
      courseId: event.courseId, 
      lessonId: event.lessonId, 
      markAsCompleted: isLessonCompleted(event.lessonId) ? true : event.markAsCompleted, 
      // markAsCompleted: event.markAsCompleted,
      time: event.time.inSeconds, 
      totalTime: event.totalTime.inSeconds
    ));
    final resultGetProgress = await getCourseProgressByIdUseCase.execute(GetCourseProgressByIdDto(id));
    emit(state.copyWith(progress: (resultGetProgress.isSuccessful) ? resultGetProgress.unwrap() : state.progress));
    if(result.isSuccessful) {
      emit(state.copyWith(progressStatus: ProgressStatus.loaded));
    } else {
      emit(ProgressError(message: result.error.message));
    }
  }
  
  Future<void> _loadLessonProgress(LessonProgressRequested event, Emitter<ProgressState> emit) async {
    emit(state.copyWith(progressStatus: ProgressStatus.fetching));
    final result = await getCourseProgressByIdUseCase.execute(GetCourseProgressByIdDto(event.courseId));
    if(result.isSuccessful) {
      final progress = result.unwrap();
      emit(state.copyWith(progress: progress, progressStatus: ProgressStatus.loaded));
    } else {
        emit(state.copyWith(progressStatus: ProgressStatus.unitialized));
    }
  }
  
  Future<void> _updateLessonProgress(ProgressLessonUpdated event, Emitter<ProgressState> emit) async {
    emit(state.copyWith(progressStatus: ProgressStatus.fetching));
    final result = await updateCourseProgressUseCase.execute(UpdateProgressDTO(
      courseId: event.courseId, 
      lessonId: event.lessonId, 
      markAsCompleted: isLessonCompleted(event.lessonId) ? true : event.markAsCompleted, 
      // markAsCompleted: event.markAsCompleted,
      time: event.time.inSeconds, 
      totalTime: event.totalTime.inSeconds
    ));
    if(result.isSuccessful) {
      emit(state.copyWith(progressStatus: ProgressStatus.loaded));
    } 
  }

  void setToInitialState() {
    emit(ProgressState());
  }

  LessonProgress getLessonById(String id) {
    return state.progress.lessonProgress.where((element) => element.lessonId == id).toList()[0];
  }

  bool isLessonCompleted(String lessonId) {
    final lessonPercent = getLessonById(lessonId).percent;
    return (lessonPercent == 100) ? true : false; 
  }

  bool isCompleted() {
    return (state.progress.percent  == 100) ? true : false;
  }

  bool checkProgress(int videoDuration, int videoTime, String lessonId) {
    final lessonById = getLessonById(lessonId);
    var progress = 0.0;
    state.progress.lessonProgress.forEach((element) {
      if(element.lessonId == lessonById.lessonId){
        progress += (videoDuration / videoTime) * 100.0;
        return;
      }
      progress += element.percent;
    });
      return ((progress / state.progress.lessonProgress.length) >= 100.0 - 0.01) ? true : false;
  }

}
