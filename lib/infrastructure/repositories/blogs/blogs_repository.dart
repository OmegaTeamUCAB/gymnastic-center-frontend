import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';
import 'package:gymnastic_center/application/models/comment.dart';
import 'package:gymnastic_center/infrastructure/dataSources/http/http_manager.dart';

class BlogsRepository implements IBlogRepository {
  final IHttpManager _httpConnectionManager;

  BlogsRepository(this._httpConnectionManager);

  @override
  Future<Result<List<Blog>>> getAllBlogs() async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'blog',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Blog> blogs = [];
        for (var blog in data) {
          List<Comment> comments = [];
          if (blog['comments'] != null) {
            for (var comment in blog['comments']) {
              comments.add(Comment(
                id: comment['id'],
                userId: comment['userId'],
                blogId: comment['blogId'],
                content: comment['content'],
                postedAt: DateTime.parse(comment['postedAt']),
                isExpanded: false,
              ));
            }
          }
          blogs.add(Blog(
            id: blog['id'],
            imageUrl: blog['imageUrl'],
            title: blog['title'],
            description: blog['description'],
            content: blog['content'],
            uploadDate: DateTime.now(),
            comments: comments,
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
      urlPath: 'blog/$blog',
      mapperCallBack: (data) {
        List<Comment> comments = [];
        if (data['comments'] != null) {
          for (var comment in data['comments']) {
            comments.add(Comment(
              id: comment['id'],
              userId: comment['userId'],
              blogId: comment['blogId'],
              content: comment['content'],
              postedAt: DateTime.parse(comment['postedAt']),
              isExpanded: false,
            ));
          }
        }
        return Blog(
          id: data['id'],
          imageUrl: data['imageUrl'],
          title: data['title'],
          description: data['description'],
          content: data['content'],
          uploadDate: DateTime.now(),
          comments: comments,
        );
      },
    );
    return result;
  }
}
