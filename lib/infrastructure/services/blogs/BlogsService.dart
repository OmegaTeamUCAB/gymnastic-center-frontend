import 'package:gymnastic_center/domain/blog/repository/IBlogRepository.dart';
import 'package:gymnastic_center/application/models/blog.dart';
import 'package:gymnastic_center/application/models/comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class BlogsService implements IBlogRepository {

@override
  Future<List<Blog>> getAllBlogs() async {
  final response = await http.get(Uri.parse('https://gymnastic-center-uo53v.ondigitalocean.app/blog'));

  if (response.statusCode == 200) {
    List<Blog> blogs = [];
    var data = jsonDecode(response.body);
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
  } else {
    throw Exception('Failed to load blogs');
  }
}

}