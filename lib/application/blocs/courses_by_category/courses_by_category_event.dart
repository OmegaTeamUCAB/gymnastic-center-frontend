part of 'courses_by_category_bloc.dart';

sealed class CoursesByCategoryEvent {
  const CoursesByCategoryEvent();
}

class CoursesByCategoryRequested extends CoursesByCategoryEvent {
  final String categoryId;
  final int page;

  CoursesByCategoryRequested({required this.categoryId, required this.page});
}
