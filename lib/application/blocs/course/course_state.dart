part of 'course_bloc.dart';

class CourseState {
  final bool isLoading;
  final int limit;
  final int offset;
  final String? currentCategory;
  final List<Course> currentCourses;
  final List<Course> popularCourses;
  final Course? course;
  final Map<String, Course> courseCache;

  CourseState({
      this.isLoading = false,
      this.limit = 10,
      this.offset = 0,
      this.currentCourses = const [],
      this.currentCategory,
      this.popularCourses = const [],
      this.course,
      this.courseCache = const {}});

  CourseState copyWith({
    bool? isLoading,
    int? limit,
    int? offset,
    List<Course>? currentCourses,
    List<Course>? popularCourses,
    String? currentCategory,
    Course? course,
    Map<String, Course>? courseCache,
  }) =>
      CourseState(
          isLoading: isLoading ?? this.isLoading,
          limit: limit ?? this.limit,
          offset: offset ?? this.offset,
          course: course ?? this.course, 
          popularCourses: popularCourses ?? this.popularCourses,
          currentCategory: currentCategory ?? this.currentCategory,
          currentCourses: currentCourses ?? this.currentCourses);
}
