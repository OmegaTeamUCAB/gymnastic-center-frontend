part of 'courses_by_category_bloc.dart';

sealed class CoursesByCategoryState extends Equatable {
  final List<Course> courses;

  CoursesByCategoryState({required this.courses});

  @override
  List<Object> get props => [courses];
}

class CoursesByCategoryLoading extends CoursesByCategoryState {
  CoursesByCategoryLoading({required super.courses});
}

class CoursesByCategorySuccess extends CoursesByCategoryState {
  CoursesByCategorySuccess({required super.courses});
}

class CoursesByCategoryFailed extends CoursesByCategoryState {
  final String message;

  CoursesByCategoryFailed({required this.message, required super.courses});

  @override
  List<Object> get props => [message];
}
