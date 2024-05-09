
import 'package:dio/dio.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/repository/course_repository.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/course/course_mapper.dart';

class CourseService extends ICourseRepository {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Environment.getApiUrl(),
    )
  );
  
  @override
  Future<Course> createUpdateCourse(Map<String, dynamic> courseDto) {
    // TODO: implement createUpdateCourse
    throw UnimplementedError();
  }
  
  @override
  Future<void> createUpdateLessonComment(Map<String, dynamic> lessonCommentDto) {
    // TODO: implement createUpdateLessonComment
    throw UnimplementedError();
  }
  
  @override
  Future<List<Course>> getAllCourses() async {
    try {
      final response = await dio.get('/courses');
      final List<Course> courses = CourseMapper.fromJsonToList(response.data);
      return courses;
   } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception(e.response?.data['message']);
      if (e.type == DioExceptionType.connectionTimeout) throw Exception('Connection Timeout');
      throw Exception('Something wrong happened');
    } catch(e) {
      throw Exception('Something wrong happened');
    }
  }
  
  @override
  Future<Course> getCourseById(String id) async {
    try {
      final response = await dio.get('/courses/$id');
      final Course course = CourseMapper.fromJson(response.data);
      return course;
   } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception(e.response?.data['message']);
      if (e.type == DioExceptionType.connectionTimeout) throw Exception('Connection Timeout');
      throw Exception('Something wrong happened');
    } catch(e) {
      throw Exception('Something wrong happened');
    }
  }
  
  @override
  Future<List<Course>> getCoursesByCategory(String id) async {
    try {
      final response = await dio.get('/courses/category/$id');
      final List<Course> courses = CourseMapper.fromJsonToList(response.data);
      return courses;
   } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception(e.response?.data['message']);
      if (e.type == DioExceptionType.connectionTimeout) throw Exception('Connection Timeout');
      throw Exception('Something wrong happened');
    } catch(e) {
      throw Exception(e.hashCode);
    }
  }
  
  @override
  Future<List<Course>> getCoursesByInstructor(String id) async {
    try {
      final response = await dio.get('/courses/instructor/$id');
      final List<Course> courses = CourseMapper.fromJsonToList(response.data);
      return courses;
   } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception(e.response?.data['message']);
      if (e.type == DioExceptionType.connectionTimeout) throw Exception('Connection Timeout');
      throw Exception('Something wrong happened');
    } catch(e) {
      throw Exception('Something wrong happened');
    }
  }

}