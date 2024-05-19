import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/course/course.dart';

abstract class ICourseRepository {
  Future<List<Course>> getCoursesByInstructor(String id);
  Future<Course> getCourseById(String id);
  Future<Course> createUpdateCourse(Map<String, dynamic> courseDto);
  Future<void> createUpdateLessonComment(Map<String, dynamic> lessonCommentDto);

  // all methods should be implemented like these
  Future<Result<List<Course>>> getAllCourses();
  Future<Result<List<Course>>> getCoursesByCategory(String categoryId);
}
