part of 'courses_by_category_bloc.dart';

sealed class CoursesByCategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CoursesByCategoryLoading extends CoursesByCategoryState {}

class CoursesByCategorySuccess extends CoursesByCategoryState {
  final List<Course> courses;

  CoursesByCategorySuccess({required this.courses});

  @override
  List<Object> get props => [courses];
}

class CoursesByCategoryFailed extends CoursesByCategoryState {
  final String message;

  CoursesByCategoryFailed({required this.message});

  @override
  List<Object> get props => [message];
}
