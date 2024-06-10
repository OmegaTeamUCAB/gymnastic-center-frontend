import 'package:dio/dio.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';
import 'package:gymnastic_center/infrastructure/mappers/course/course_mapper.dart';

class CourseRepository extends ICourseRepository {
  final IHttpManager _httpConnectionManager;

  CourseRepository(this._httpConnectionManager);

  @override
  Future<Result<List<Course>>> getAllCourses({int page = 1, int perPage = 15}) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'course/many?page=$page&perPage=$perPage',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Course> courses = [];
        for (var course in data) {
          courses.add(Course(
            id: course['id'],
            imageUrl: course['image'],
            categoryId: course['category'],
            name: course['title'],
            trainer: course['trainer'],
            createdAt: course['date'],
          ));
        }
        return courses;
      },
    );
    return result;
  }

  @override
  Future<Result<Course>> getCourseById(String id) async {
    final response = await _httpConnectionManager.makeRequest(
      urlPath: '/course/one/$id',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        final Course course = CourseMapper.fromJson(data);
        return course;
      },
    );
    return response;
  }

  @override
  Future<Result<List<Course>>> getCoursesByCategory({required String categoryId, int page = 1, int perPage = 15}) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'course/many?page=$page&perPage=$perPage&category=$categoryId',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Course> courses = [];
        for (var course in data) {
          courses.add(Course(
            id: course['id'],
            imageUrl: course['image'],
            categoryId: course['category'],
            name: course['title'],
            trainer: course['trainer'],
            createdAt: course['date'],
          ));
        }
        return courses;
      },
    );
    return result;
  }

  @override
  Future<Result<List<Course>>> getCoursesByInstructor({required String id, int page = 1, int perPage = 15}) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: '/course/many?page=$page&perPage=$perPage&trainer=$id',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Course> courses = [];
        for (var course in data) {
          courses.add(Course(
            id: course['id'],
            imageUrl: course['image'],
            categoryId: course['category'],
            name: course['title'],
            trainer: course['trainer'],
            createdAt: course['date'],
          ));
        }
        return courses;
      },
    );
    return result;
  }
}
