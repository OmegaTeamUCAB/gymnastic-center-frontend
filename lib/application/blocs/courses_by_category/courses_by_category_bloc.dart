import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/course/get_courses_by_category.use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';

part 'courses_by_category_event.dart';
part 'courses_by_category_state.dart';

class CoursesByCategoryBloc
    extends Bloc<CoursesByCategoryEvent, CoursesByCategoryState> {
  final GetCoursesByCategoryUseCase getCoursesByCategoryUseCase;
  String categoryId = '';
  int page;
  int perPage;
  bool lastPage = false;
  bool loadingPage = false;
  
  CoursesByCategoryBloc(this.getCoursesByCategoryUseCase, {
    this.page = 1, 
    this.perPage = 15, 
  })
      : super(CoursesByCategoryLoading(courses: const [])) {
    on<CoursesByCategoryRequested>(_getCoursesByCategory);
    on<NextPageLoaded>(_loadPage);
  }

  Future<void> _loadPage(NextPageLoaded event,
      Emitter<CoursesByCategoryState> emit) async {
    loadingPage = true;
    final result = await getCoursesByCategoryUseCase
        .execute(GetCoursesByCategoryDto(categoryId: categoryId, page: page, perPage: perPage));
    if (result.isSuccessful) {
      final courses = result.unwrap();
      if(courses.isEmpty) lastPage = true;
      page = page + 1;
      loadingPage = false;
      emit(CoursesByCategorySuccess(courses: [...state.courses, ...courses]));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(CoursesByCategoryFailed(courses: state.courses, message: e.toString()));
      }
    }
  }

  Future<void> loadNextPage() async {
    if(state is CoursesByCategoryFailed || lastPage == true || loadingPage == true) return;
    add(NextPageLoaded());
  }

  Future<void> _getCoursesByCategory(CoursesByCategoryRequested event,
      Emitter<CoursesByCategoryState> emit) async {
    
    emit(CoursesByCategoryLoading(courses: state.courses));
    if (event.categoryId != categoryId) {
          page = 1;
          perPage = 15;
    }
    categoryId = event.categoryId;
    final result = await getCoursesByCategoryUseCase
        .execute(GetCoursesByCategoryDto(categoryId: event.categoryId, page: page, perPage: perPage));
    if (result.isSuccessful) {
      page = page + 1;
      emit(CoursesByCategorySuccess(courses: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(CoursesByCategoryFailed(courses: state.courses, message: e.toString()));
      }
    }
  }
}
