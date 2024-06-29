part of 'feature_courses_bloc.dart';

sealed class FeatureCoursesEvent{
  const FeatureCoursesEvent();
}

class FeatureCoursesRequested extends FeatureCoursesEvent {
  final int page;
  const FeatureCoursesRequested(this.page);
}
