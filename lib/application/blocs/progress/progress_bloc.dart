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
      markAsCompleted: event.markAsCompleted, 
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
      emit(ProgressError(message: result.error.message));
    }
  }
  
  Future<void> _updateLessonProgress(ProgressLessonUpdated event, Emitter<ProgressState> emit) async {
    emit(state.copyWith(progressStatus: ProgressStatus.fetching));
    final lessonPercent = getLessonById(event.lessonId).percent;
    final result = await updateCourseProgressUseCase.execute(UpdateProgressDTO(
      courseId: event.courseId, 
      lessonId: event.lessonId, 
      // markAsCompleted: (lessonPercent == 100 || lessonPercent == 1) ? true : event.markAsCompleted, 
      markAsCompleted: event.markAsCompleted, 
      time: event.time.inSeconds, 
      totalTime: event.totalTime.inSeconds
    ));
    if(result.isSuccessful) {
      emit(state.copyWith(progressStatus: ProgressStatus.loaded));
    } else {
      emit(ProgressError(message: result.error.message));
    }
  }

  void setToInitialState() {
    emit(ProgressState());
  }

  LessonProgress getLessonById(String id) {
    return state.progress.lessonProgress.where((element) => element.lessonId == id).toList()[0];
  }

}
