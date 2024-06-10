import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/course/course.dart';

abstract class ICourseRepository {
  Future<Result<List<Course>>> getCoursesByInstructor(String id);
  Future<Result<Course>> getCourseById(String id);
  Future<Result<List<Course>>> getAllCourses();
  Future<Result<List<Course>>> getCoursesByCategory(String categoryId);
}
