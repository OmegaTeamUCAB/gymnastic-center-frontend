part of 'all_courses_bloc.dart';

sealed class AllCoursesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AllCoursesLoading extends AllCoursesState {}

class AllCoursesSuccess extends AllCoursesState {
  final List<Course> courses;

  AllCoursesSuccess({required this.courses});

  @override
  List<Object> get props => [courses];
}

class AllCoursesFailed extends AllCoursesState {
  final String message;

  AllCoursesFailed({required this.message});

  @override
  List<Object> get props => [message];
}
