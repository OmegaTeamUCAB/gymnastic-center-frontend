sealed class PlanCoursesEvent {
  const PlanCoursesEvent();
}

class PlanCoursesRequested extends PlanCoursesEvent {
  final int page;
  final String userId;
  const PlanCoursesRequested(this.page, this.userId);
}
