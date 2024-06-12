import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';

class BlogsRepository implements IBlogRepository {
  final IHttpManager _httpConnectionManager;

  BlogsRepository(this._httpConnectionManager);

  @override
  Future<Result<List<Blog>>> getBlogs(GetBlogsDto dto) async {
    var queryParameters = {
      'page': dto.page.toString(),
      'perPage': '15',
      if (dto.categoryId != null) 'category': dto.categoryId.toString(),
      if (dto.trainerId != null) 'trainer': dto.trainerId.toString(),
    };

    var queryString = Uri(queryParameters: queryParameters).query;

    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'blog/many?$queryString',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Blog> blogs = [];
        for (var blog in data) {
          blogs.add(Blog(
            id: blog['id'],
            images: [blog['image']],
            title: blog['title'],
            trainer: blog['trainer'],
            uploadDate: blog['date'],
          ));
        }
        return blogs;
      },
    );
    return result;
  }

  @override
  Future<Result<List<Blog>>> getBlogsByCategory(String categoryId) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'blog/many?page=1&perPage=10&category=$categoryId',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Blog> blogs = [];
        for (var blog in data) {
          blogs.add(Blog(
            id: blog['id'],
            images: [blog['image']],
            title: blog['title'],
            trainer: blog['trainer'],
            uploadDate: blog['date'],
          ));
        }
        return blogs;
      },
    );
    return result;
  }

  @override
  Future<Result<Blog>> getBlogById(String blog) async {
    final result = await _httpConnectionManager.makeRequest(
      httpMethod: 'GET',
      urlPath: 'blog/one/$blog',
      mapperCallBack: (data) {
        return Blog(
          id: data['id'],
          title: data['title'],
          images: data['images'],
          trainer: data['trainer'],
          content: data['description'],
          uploadDate: data['date'],
          tags: data['tags'],
        );
      },
    );
    return result;
  }
}
