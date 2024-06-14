import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/course/get_all_courses_by_trainer.use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';

part 'all_course_by_trainer_event.dart';
part 'all_course_by_trainer_state.dart';

class AllCourseByTrainerBloc
    extends Bloc<AllCourseByTrainerEvent, AllCourseByTrainerState> {
  final GetAllCoursesByTrainerUseCase getAllCoursesByTrainerUseCase;
  AllCourseByTrainerBloc(this.getAllCoursesByTrainerUseCase)
      : super(AllCourseByTrainerLoading()) {
    on<AllCourseByTrainerRequested>(_getAllCoursesByTrainer);
  }

  Future<void> _getAllCoursesByTrainer(AllCourseByTrainerRequested event,
      Emitter<AllCourseByTrainerState> emit) async {
    emit(AllCourseByTrainerLoading());
    final result = await getAllCoursesByTrainerUseCase
        .execute(GetAllCoursesByTrainerDto(event.page, event.trainerId));
    if (result.isSuccessful) {
      final previousCourses = state is AllCoursesByTrainerSuccess
          ? (state as AllCoursesByTrainerSuccess).courses
          : <Course>[];
      final currentCourses = result.unwrap();
      final allCoursesByTariner = [...previousCourses, ...currentCourses];
      emit(AllCoursesByTrainerSuccess(courses: allCoursesByTariner));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(AllCourseByTrainerFailed(message: e.toString()));
      }
    }
  }
}
