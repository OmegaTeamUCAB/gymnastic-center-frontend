import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';

abstract class IBlogRepository {
  Future<Result<List<Blog>>> getAllBlogs();
  Future<Result<Blog>> getBlogById(String blog);
}
