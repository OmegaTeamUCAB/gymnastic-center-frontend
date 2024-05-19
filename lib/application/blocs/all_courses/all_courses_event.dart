part of 'all_courses_bloc.dart';

sealed class AllCoursesEvent {
  const AllCoursesEvent();
}

class AllCoursesRequested extends AllCoursesEvent {
  AllCoursesRequested();
}
