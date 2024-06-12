import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/course/course.dart';

abstract class ICourseRepository {
  Future<Result<List<Course>>> getCoursesByTrainer(String id);
  Future<Result<Course>> getCourseById(String id);
  Future<Result<List<Course>>> getAllCourses(int page);
  Future<Result<List<Course>>> getCoursesByCategory(
      String categoryId, int page);
}
