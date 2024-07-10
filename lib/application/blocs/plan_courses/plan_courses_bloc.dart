import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/plan_courses/plan_courses_event.dart';
import 'package:gymnastic_center/application/blocs/plan_courses/plan_courses_state.dart';
import 'package:gymnastic_center/application/use_cases/course/get_courses.use_case.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

class PlanCoursesBloc extends Bloc<PlanCoursesEvent, PlanCoursesState> {
  final GetCoursesUseCase getCoursesUseCase;
  PlanCoursesBloc(this.getCoursesUseCase) : super(PlanCoursesLoading()) {
    on<PlanCoursesRequested>(_getPlanCourses);
  }

  Future<void> _getPlanCourses(
      PlanCoursesRequested event, Emitter<PlanCoursesState> emit) async {
    emit(PlanCoursesLoading());
    final result = await getCoursesUseCase
        .execute(GetCoursesDto(page: event.page, filter: event.filter));
    if (result.isSuccessful) {
      emit(PlanCoursesSuccess(courses: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(PlanCoursesFailed(message: e.toString()));
      }
    }
  }
}
