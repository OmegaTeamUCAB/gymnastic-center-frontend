import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/course/get_courses.use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

part 'all_course_by_trainer_event.dart';
part 'all_course_by_trainer_state.dart';

class AllCourseByTrainerBloc
    extends Bloc<AllCourseByTrainerEvent, AllCourseByTrainerState> {
  final GetCoursesUseCase getAllCoursesByTrainerUseCase;
  final Map<String, List<Course>> _cachedCoursesByTrainer = {};

  AllCourseByTrainerBloc(this.getAllCoursesByTrainerUseCase)
      : super(AllCourseByTrainerLoading()) {
    on<AllCourseByTrainerRequested>(_getAllCoursesByTrainer);
  }

  Future<void> _getAllCoursesByTrainer(AllCourseByTrainerRequested event,
      Emitter<AllCourseByTrainerState> emit) async {
    if (_cachedCoursesByTrainer.containsKey(event.trainerId)) {
      emit(AllCoursesByTrainerSuccess(
          courses: _cachedCoursesByTrainer[event.trainerId]!));
    } else {
      emit(AllCourseByTrainerLoading());
      final result = await getAllCoursesByTrainerUseCase
          .execute(GetCoursesDto(trainerId: event.trainerId, page: event.page));
      if (result.isSuccessful) {
        _cachedCoursesByTrainer[event.trainerId] = result.unwrap();
        emit(AllCoursesByTrainerSuccess(
            courses: _cachedCoursesByTrainer[event.trainerId]!));
      } else {
        try {
          throw result.unwrap();
        } catch (e) {
          emit(AllCourseByTrainerFailed(message: e.toString()));
        }
      }
    }
  }
}
