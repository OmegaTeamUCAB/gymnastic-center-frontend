import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/course_repository.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository courseRepository;
  CourseBloc(this.courseRepository) : super(CourseState()) {
    on<AddCourses>(_addCourses);
    on<AddToPopularCourses>(_addToPopularCourses);
    on<GetCourseById>(_getCourseById);
  }

  _addToPopularCourses(AddToPopularCourses event, Emitter<CourseState> emit) {
    emit(state.copyWith(isLoading: false, popularCourses: event.courses));
  }

  _addCourses(AddCourses event, Emitter<CourseState> emit) {
    emit(state.copyWith(isLoading: false, currentCourses: event.courses));
  }

  _getCourseById(GetCourseById event, Emitter<CourseState> emit) async {
    emit(state.copyWith(isLoading: true));
    final course = await courseRepository.getCourseById(event.courseId);
    emit(state.copyWith(isLoading: false, course: course.unwrap()));
  }
}
