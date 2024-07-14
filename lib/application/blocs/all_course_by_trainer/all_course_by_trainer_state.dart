part of 'all_course_by_trainer_bloc.dart';

sealed class AllCourseByTrainerState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AllCourseByTrainerInitial extends AllCourseByTrainerState {}

final class AllCourseByTrainerLoading extends AllCourseByTrainerState {}

class AllCoursesByTrainerSuccess extends AllCourseByTrainerState {
  final List<Course> courses;

  AllCoursesByTrainerSuccess({required this.courses});

  @override
  List<Object> get props => [courses];
}

class AllCourseByTrainerFailed extends AllCourseByTrainerState {
  final String message;

  AllCourseByTrainerFailed({required this.message});

  @override
  List<Object> get props => [message];
}
