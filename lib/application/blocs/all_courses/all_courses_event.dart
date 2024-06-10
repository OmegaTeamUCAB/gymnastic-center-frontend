part of 'all_courses_bloc.dart';

sealed class AllCoursesEvent {
  const AllCoursesEvent();
}

class AllCoursesRequested extends AllCoursesEvent {
  final int page;
  const AllCoursesRequested(this.page);
}
