sealed class PlanCoursesEvent {
  const PlanCoursesEvent();
}

class PlanCoursesRequested extends PlanCoursesEvent {
  final int page;
  const PlanCoursesRequested(this.page);
}
