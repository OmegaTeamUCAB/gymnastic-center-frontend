import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';
import 'package:gymnastic_center/infrastructure/mappers/course/course_mapper.dart';

class CourseRepository extends ICourseRepository {
  final IHttpManager _httpConnectionManager;

  CourseRepository(this._httpConnectionManager);

  @override
  Future<Result<List<Course>>> getCourses(GetCoursesDto dto) async {
    var queryParameters = {
      'page': dto.page.toString(),
      'perPage': '15',
      if(dto.filter != null) 'filter':dto.filter.toString(),
      if (dto.categoryId != null) 'category': dto.categoryId.toString(),
      if (dto.trainerId != null) 'trainer': dto.trainerId.toString(),
    };

    var queryString = Uri(queryParameters: queryParameters).query;
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'course/many?$queryString',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Course> courses = [];
        for (var course in data) {
          courses.add(Course(
            id: course['id'],
            imageUrl: course['image'],
            category: course['category'],
            description: course['description'],
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
  Future<Result<void>> courseClicked(String courseId) async {
    final response = await _httpConnectionManager.makeRequest(
      urlPath: '/click/$courseId',
      httpMethod: 'POST',
      mapperCallBack: (data) => null,
    );
    return response;
  }
}
