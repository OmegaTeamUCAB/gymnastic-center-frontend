part of 'feature_courses_bloc.dart';

sealed class FeatureCoursesState extends Equatable {
  
  @override
  List<Object> get props => [];
}

final class FeatureCoursesLoading extends FeatureCoursesState {}

class FeatureCoursesSuccess extends FeatureCoursesState {
  final List<Course> courses;

  FeatureCoursesSuccess({required this.courses});

}

class FeatureCoursesFailed extends FeatureCoursesState {
  final String message;

  FeatureCoursesFailed({required this.message});

  @override
  List<Object> get props => [message];
}

