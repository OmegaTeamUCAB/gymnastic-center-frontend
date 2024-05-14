import 'package:gymnastic_center/domain/course/course.dart';

abstract class ICourseRepository {
  Future<List<Course>> getAllCourses();
  Future<List<Course>> getCoursesByCategory(String id);
  Future<List<Course>> getCoursesByInstructor(String id);
  Future<Course> getCourseById(String id);
}
