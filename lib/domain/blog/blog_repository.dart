import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';

class GetBlogsDto {
  final int page;
  final String? categoryId;
  final String? trainerId;
  GetBlogsDto({this.categoryId, required this.page, this.trainerId});
}

abstract class IBlogRepository {
  Future<Result<List<Blog>>> getBlogs(GetBlogsDto dto);
  Future<Result<Blog>> getBlogById(String blog);
}
