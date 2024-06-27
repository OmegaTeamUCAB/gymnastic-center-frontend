import 'package:gymnastic_center/application/repositories/search/search_repository.dart';
import 'package:gymnastic_center/application/repositories/search/search_results.dart';
import 'package:gymnastic_center/application/use_cases/search/search.use_case.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';

class SearchRepository implements ISearchRepository {
  final IHttpManager _httpConnectionManager;

  SearchRepository(this._httpConnectionManager);

  @override
  Future<Result<SearchResults>> search(SearchDto dto) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'search/all?term=${dto.searchTerm}&tags=${dto.tags.join(',')}',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<SearchHit> blogs = [];
        List<SearchHit> courses = [];
        for (var course in data['courses']) {
          courses.add(SearchHit(
            id: course['id'],
            title: course['title'],
            image: course['image'],
            trainer: course['trainer'],
            category: course['category'],
          ));
        }
        for (var blog in data['blogs']) {
          blogs.add(SearchHit(
            id: blog['id'],
            title: blog['title'],
            image: blog['image'],
            trainer: blog['trainer'],
            category: blog['category'],
          ));
        }
        return SearchResults(courses: courses, blogs: blogs);
      },
    );
    return result;
  }

  @override
  Future<Result<dynamic>> getSearchTags() async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'search/popular/tags',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<dynamic> searchTags = [];
        for (var tag in searchTags) {
          //TODO: FIX
          // searchTags.add(SearchTags(
          //   tag
          // ));
        }
        return searchTags;
      },
    );
    return result;
  }
}
