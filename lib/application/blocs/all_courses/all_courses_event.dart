part of 'all_courses_bloc.dart';

sealed class AllCoursesEvent {
  const AllCoursesEvent();
}

class CoursesByCategoryRequested extends AllCoursesEvent {
  CoursesByCategoryRequested();
}
