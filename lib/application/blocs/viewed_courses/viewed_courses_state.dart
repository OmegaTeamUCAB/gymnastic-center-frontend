import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/domain/progress/progress.dart';

sealed class ViewedCoursesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ViewedCoursesLoading extends ViewedCoursesState {}

class ViewedCoursesSuccess extends ViewedCoursesState {
  final List<CourseProgress> courses;

  ViewedCoursesSuccess({required this.courses});
}

class ViewedCoursesFailed extends ViewedCoursesState {
  final String message;

  ViewedCoursesFailed({required this.message});

  @override
  List<Object> get props => [message];
}
