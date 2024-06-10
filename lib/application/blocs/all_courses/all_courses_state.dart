part of 'all_courses_bloc.dart';

sealed class AllCoursesState extends Equatable {
  final List<Course> courses;
  
  AllCoursesState({required this.courses});

  @override
  List<Object> get props => [courses];
}

final class AllCoursesLoading extends AllCoursesState {
  AllCoursesLoading({required super.courses});
}

class AllCoursesSuccess extends AllCoursesState {

  AllCoursesSuccess({required super.courses});

}

class AllCoursesFailed extends AllCoursesState {
  final String message;

  AllCoursesFailed({required this.message, required super.courses});

  @override
  List<Object> get props => [message];
}
