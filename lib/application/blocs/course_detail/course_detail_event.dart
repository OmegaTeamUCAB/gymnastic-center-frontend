part of 'course_detail_bloc.dart';

sealed class CourseDetailEvent {}

class CourseRequested extends CourseDetailEvent {
  final String id;

  CourseRequested({required this.id});
}

