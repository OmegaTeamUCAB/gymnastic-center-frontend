import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/domain/course/course.dart';

sealed class PlanCoursesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class PlanCoursesLoading extends PlanCoursesState {}

class PlanCoursesSuccess extends PlanCoursesState {
  final List<Course> courses;

  PlanCoursesSuccess({required this.courses});

  @override
  List<Object> get props => [courses];
}

class PlanCoursesFailed extends PlanCoursesState {
  final String message;

  PlanCoursesFailed({required this.message});

  @override
  List<Object> get props => [message];
}
