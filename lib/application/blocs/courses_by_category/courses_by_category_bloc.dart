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
        .execute(GetCoursesByCategoryDto(event.categoryId));
    if (result.isSuccessful) {
      emit(CoursesByCategoryLoaded(courses: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(CoursesByCategoryFailed(message: e.toString()));
      }
    }
  }
}
