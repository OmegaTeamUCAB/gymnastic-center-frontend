import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/course/course.dart';

class GetCoursesDto {
  final int page;
  final String? categoryId;
  final String? trainerId;
  GetCoursesDto({this.categoryId, required this.page, this.trainerId});
}

abstract class ICourseRepository {
  Future<Result<Course>> getCourseById(String id);
  Future<Result<List<Course>>> getCourses(GetCoursesDto dto);
}
