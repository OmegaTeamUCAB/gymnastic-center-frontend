part of 'viewed_courses_bloc.dart';

sealed class ViewedCoursesEvent {
  const ViewedCoursesEvent();
}

class ViewedCoursesRequested extends ViewedCoursesEvent {
  final int page;
  const ViewedCoursesRequested(this.page);
}
