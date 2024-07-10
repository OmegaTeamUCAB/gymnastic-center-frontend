import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/course/get_course_by_id.use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';

part 'course_detail_event.dart';
part 'course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  final GetCourseByIdUseCase getCourseByIdUseCase;

  CourseDetailBloc(this.getCourseByIdUseCase) : super(CourseLoading()) {
    on<CourseRequested>(_getCourseRequested);
  }

  Future<void> _getCourseRequested(
      CourseRequested event, Emitter<CourseDetailState> emit) async {
    emit(CourseLoading());
    final result =
        await getCourseByIdUseCase.execute(GetCourseByIdDto(event.id));
    if (result.isSuccessful) {
      emit(CourseFetched(course: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(CourseError(message: e.toString()));
      }
    }
  }
}
