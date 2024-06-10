import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/course/get_courses_by_category.use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';

part 'courses_by_category_event.dart';
part 'courses_by_category_state.dart';

class CoursesByCategoryBloc
    extends Bloc<CoursesByCategoryEvent, CoursesByCategoryState> {
  final GetCoursesByCategoryUseCase getCoursesByCategoryUseCase;
  CoursesByCategoryBloc(this.getCoursesByCategoryUseCase)
      : super(CoursesByCategoryLoading()) {
    on<CoursesByCategoryRequested>(_getCoursesByCategory);
  }

  Future<void> _getCoursesByCategory(CoursesByCategoryRequested event,
      Emitter<CoursesByCategoryState> emit) async {
    emit(CoursesByCategoryLoading());
    final result = await getCoursesByCategoryUseCase
        .execute(GetCoursesByCategoryDto(event.categoryId, event.page));
    if (result.isSuccessful) {
      final previousCourses = state is CoursesByCategorySuccess
          ? (state as CoursesByCategorySuccess).courses
          : <Course>[];
      final currentCourses = result.unwrap();
      final allCourses = [...previousCourses, ...currentCourses];
      emit(CoursesByCategorySuccess(courses: allCourses));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(CoursesByCategoryFailed(message: e.toString()));
      }
    }
  }
}
