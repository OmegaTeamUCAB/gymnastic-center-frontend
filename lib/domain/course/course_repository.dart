import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/course/course.dart';

class GetCoursesDto {
  final int page;
  final String? filter;
  final String? categoryId;
  final String? trainerId;
  final String? userId;
  GetCoursesDto({
    this.filter,
    this.categoryId,
    required this.page,
    this.trainerId,
    this.userId,
  });
}

abstract class ICourseRepository {
  Future<Result<Course>> getCourseById(String id);
  Future<Result<List<Course>>> getCourses(GetCoursesDto dto);
  Future<Result<void>> courseClicked(String courseId);
}
