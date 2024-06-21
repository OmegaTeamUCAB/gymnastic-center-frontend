import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/course/get_courses.use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

part 'courses_by_category_event.dart';
part 'courses_by_category_state.dart';

class CoursesByCategoryBloc
    extends Bloc<CoursesByCategoryEvent, CoursesByCategoryState> {
  final GetCoursesUseCase getCoursesUseCase;
  final Map<String, List<Course>> _cachedCoursesByCategory = {};

  CoursesByCategoryBloc(this.getCoursesUseCase)
      : super(CoursesByCategoryLoading()) {
    on<CoursesByCategoryRequested>(_getCoursesByCategory);
  }

  Future<void> _getCoursesByCategory(CoursesByCategoryRequested event,
      Emitter<CoursesByCategoryState> emit) async {
    if (_cachedCoursesByCategory.containsKey(event.categoryId)) {
      emit(CoursesByCategorySuccess(
          courses: _cachedCoursesByCategory[event.categoryId]!));
    } else {
      emit(CoursesByCategoryLoading());
      final result = await getCoursesUseCase.execute(
          GetCoursesDto(categoryId: event.categoryId, page: event.page));
      if (result.isSuccessful) {
        _cachedCoursesByCategory[event.categoryId] = result.unwrap();
        emit(CoursesByCategorySuccess(
            courses: _cachedCoursesByCategory[event.categoryId]!));
      } else {
        try {
          throw result.unwrap();
        } catch (e) {
          emit(CoursesByCategoryFailed(message: e.toString()));
        }
      }
    }
  }
}
