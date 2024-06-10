part of 'courses_by_category_bloc.dart';

sealed class CoursesByCategoryEvent {
  const CoursesByCategoryEvent();
}

class NextPageLoaded extends CoursesByCategoryEvent {}

class CoursesByCategoryRequested extends CoursesByCategoryEvent {
  final String categoryId;

  CoursesByCategoryRequested({required this.categoryId});
}
