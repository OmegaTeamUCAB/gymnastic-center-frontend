import 'package:gymnastic_center/application/models/blog.dart';

abstract class IBlogRepository {
  Future<List<Blog>> getAllBlogs();
}