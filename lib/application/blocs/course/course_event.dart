part of 'course_bloc.dart';

sealed class CourseEvent {
  const CourseEvent();
}

class AddCoursesByCategory extends CourseEvent {
  final String categoryId;

  AddCoursesByCategory({required this.categoryId});
}

class AddPopularCourses extends CourseEvent {}

class GetMostPopularCourses extends CourseEvent {}

class CourseClicked extends CourseEvent {
  final String courseId;

  CourseClicked({required this.courseId});
}

class AddCourses extends CourseEvent {
  final List<Course> courses;

  AddCourses({required this.courses});
}

class GetCourseById extends CourseEvent {
  final String courseId;

  GetCourseById({required this.courseId});
}

class AddToPopularCourses extends CourseEvent {
  final List<Course> courses;

  AddToPopularCourses({required this.courses});
}
