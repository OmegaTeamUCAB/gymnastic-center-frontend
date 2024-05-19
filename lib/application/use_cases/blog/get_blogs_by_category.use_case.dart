import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';

class GetBlogByCategoryDto {
  final String categoryId;

  GetBlogByCategoryDto(this.categoryId);
}

class GetBlogByCategoryUseCase
    extends IUseCase<GetBlogByCategoryDto, List<Blog>> {
  final IBlogRepository blogRepository;

  GetBlogByCategoryUseCase(this.blogRepository);

  @override
  Future<Result<List<Blog>>> execute(GetBlogByCategoryDto dto) async {
    return await blogRepository.getBlogsByCategory(dto.categoryId);
  }
}
