sealed class PlanCoursesEvent {
  const PlanCoursesEvent();
}

class PlanCoursesRequested extends PlanCoursesEvent {
  final int page;
  final String filter;
  const PlanCoursesRequested({required this.page, required this.filter});
}
