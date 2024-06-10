part of 'course_detail_bloc.dart';

enum CourseStatus {
  loading,
  fetched
}

sealed class CourseState extends Equatable {
  @override
  List<Object> get props => [];
}

class CourseError extends CourseState {
  final String message;

  CourseError({required this.message});

} 

class CourseLoading extends CourseState {}

class CourseFetched extends CourseState {
  final Course course;

  CourseFetched({
    required this.course, 
});

  CourseFetched copyWith({
    Course? course,
  }) => CourseFetched(
    course: course ?? this.course,
  );
  
  @override
  List<Object> get props => [course];
}
