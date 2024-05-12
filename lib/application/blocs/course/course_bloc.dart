import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/infrastructure/repositories/course/course_service.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseService courseService;
  CourseBloc(this.courseService) : super(CourseState()) {
    
    on<AddCoursesByCategory>(_addByCategory);
    on<AddPopularCourses>(_addPopularCourses);
    on<GetMostPopularCourses>(_getMostPopular);
    on<AddCourses>(_addCourses);
    on<AddToPopularCourses>(_addToPopularCourses);
    on<GetCourseById>(_getCourseById);
    add(GetMostPopularCourses());
  }

  _addByCategory(AddCoursesByCategory event, Emitter<CourseState> emit) async {
    emit(state.copyWith(isLoading: true, currentCategory: event.categoryId));
    final courses =
        await courseService.getCoursesByCategory(event.categoryId);
    add(AddCourses(courses: courses));
  }

  _addPopularCourses(AddPopularCourses event, Emitter<CourseState> emit) async {
    emit(state.copyWith(isLoading: true, currentCategory: 'popular'));
    final courses =
        await courseService.getAllCourses();
    add(AddCourses(courses: courses));
  }

  _getMostPopular(
      GetMostPopularCourses event, Emitter<CourseState> emit) async {
    emit(state.copyWith(isLoading: true, currentCategory: 'empty'));
    final courses = await courseService.getAllCourses();
    add(AddToPopularCourses(courses: courses));
  }

  _addToPopularCourses(AddToPopularCourses event, Emitter<CourseState> emit){
    emit(state.copyWith(isLoading: false, popularCourses: event.courses));
  }

  _addCourses(AddCourses event, Emitter<CourseState> emit) {
    emit(state.copyWith(isLoading: false, currentCourses: event.courses));
  }

  _getCourseById(GetCourseById event, Emitter<CourseState> emit) async {
    emit(state.copyWith(isLoading: true));
    final course = await courseService.getCourseById(event.courseId);
    emit(state.copyWith(isLoading: false, course: course));
  }
}
