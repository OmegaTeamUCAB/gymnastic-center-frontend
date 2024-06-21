import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/course/get_course_by_id.use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';

part 'course_detail_event.dart';
part 'course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  final GetCourseByIdUseCase getCourseByIdUseCase;
  final Map<String, Course> _cachedCourses = {};

  CourseDetailBloc({required this.getCourseByIdUseCase})
      : super(CourseLoading()) {
    on<CourseRequested>(_getCourseRequested);
  }

  Future<void> _getCourseRequested(
      CourseRequested event, Emitter<CourseDetailState> emit) async {
    if (_cachedCourses.containsKey(event.id)) {
      emit(CourseFetched(course: _cachedCourses[event.id]!));
    } else {
      emit(CourseLoading());
      final result =
          await getCourseByIdUseCase.execute(GetCourseByIdDto(event.id));
      if (result.isSuccessful) {
        _cachedCourses[event.id] = result.unwrap();
        emit(CourseFetched(course: _cachedCourses[event.id]!));
      } else {
        try {
          throw result.unwrap();
        } catch (e) {
          emit(CourseError(message: e.toString()));
        }
      }
    }
  }
}
