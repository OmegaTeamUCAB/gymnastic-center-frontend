part of 'course_detail_bloc.dart';

enum CourseStatus {
  loading,
  fetched
}

sealed class CourseDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class CourseError extends CourseDetailState {
  final String message;

  CourseError({required this.message});

} 

class CourseLoading extends CourseDetailState {}

class CourseFetched extends CourseDetailState {
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
