import 'package:gymnastic_center/domain/blog/blog.dart';

abstract class IBlogRepository {
  Future<List<Blog>> getAllBlogs();
}
