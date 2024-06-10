import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/course/course.dart';

abstract class ICourseRepository {
  Future<Result<List<Course>>> getCoursesByInstructor({required String id, int page = 1, int perPage = 15});
  Future<Result<Course>> getCourseById(String id);
  Future<Result<List<Course>>> getAllCourses({int page = 1, int perPage = 15});
  Future<Result<List<Course>>> getCoursesByCategory({required String categoryId, int page = 1, int perPage = 15});
}
