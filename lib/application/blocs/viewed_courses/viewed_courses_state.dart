import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/domain/course/course.dart';

sealed class ViewedCoursesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ViewedCoursesLoading extends ViewedCoursesState {}

class ViewedCoursesSuccess extends ViewedCoursesState {
  final List<Course> courses;

  ViewedCoursesSuccess({required this.courses});
}

class ViewedCoursesFailed extends ViewedCoursesState {
  final String message;

  ViewedCoursesFailed({required this.message});

  @override
  List<Object> get props => [message];
}
