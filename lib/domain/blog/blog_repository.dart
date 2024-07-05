import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';

enum BlogSorting { recent, popular }

class GetBlogsDto {
  final int page;
  final String? filter;
  final String? categoryId;
  final String? trainerId;
  GetBlogsDto({
    this.categoryId,
    required this.page,
    this.trainerId,
    BlogSorting sorting = BlogSorting.recent,
  }) : filter = sorting.toString().split('.').last;
}

abstract class IBlogRepository {
  Future<Result<List<Blog>>> getBlogs(GetBlogsDto dto);
  Future<Result<Blog>> getBlogById(String blog);
}
