import 'package:gymnastic_center/application/repositories/search/search_repository.dart';
import 'package:gymnastic_center/application/repositories/search/search_results.dart';
import 'package:gymnastic_center/application/use_cases/search/search.use_case.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';

class SearchRepository implements ISearchRepository {
  final IHttpManager _httpConnectionManager;

  SearchRepository(this._httpConnectionManager);

  @override
  Future<Result<SearchResults>> search(SearchDto dto) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath:
          'search?term=${dto.searchTerm}&page=${dto.page}&perPage=${dto.perPage}&${dto.tags.map((tag) => 'tag=$tag').join('&')}',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Blog> blogs = [];
        List<Course> courses = [];
        // CourseMapper should be removed
        for (var course in data['courses']) {
          courses.add(Course(
            id: course['id'],
            name: course['title'],
            imageUrl: course['imageUrl'],
            trainer: course['instructorName'],
            description: course['description'],
            categoryId: course['categoryName'],
            tags: course['tags'],
          ));
        }
        for (var blog in data['blogs']) {
          blogs.add(Blog(
            id: blog['id'],
            title: blog['title'],
            description: blog['description'],
            tags: [blog['tags']],
            images: [blog['imageUrl']],
            category: blog['categoryName'],
            trainer: blog['instructorName'],
            content: blog['content'],
          ));
        }
        return SearchResults(courses: courses, blogs: blogs);
      },
    );
    return result;
  }
}
