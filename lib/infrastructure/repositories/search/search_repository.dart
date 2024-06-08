import 'package:gymnastic_center/application/repositories/search/search_repository.dart';
import 'package:gymnastic_center/application/repositories/search/search_results.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';
import 'package:gymnastic_center/infrastructure/mappers/course/course_mapper.dart';

class SearchRepository implements ISearchRepository {
  final IHttpManager _httpConnectionManager;

  SearchRepository(this._httpConnectionManager);

  @override
  Future<Result<SearchResults>> search(String searchTerm) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'search/$searchTerm',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Blog> blogs = [];
        List<Course> courses = [];
        // CourseMapper should be removed
        courses = CourseMapper.fromJsonToList(data['courses']);
        for (var blog in data) {
          blogs.add(Blog(
            id: blog['id'],
            images: [blog['image']],
            title: blog['title'],
            trainer: blog['trainer'],
            description: blog['description'],
            content: blog['content'],
            uploadDate: blog['date'],
          ));
        }
        return SearchResults(courses: courses, blogs: blogs);
      },
    );
    return result;
  }
}
