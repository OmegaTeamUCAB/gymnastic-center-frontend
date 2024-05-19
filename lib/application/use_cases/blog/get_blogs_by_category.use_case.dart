import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';

class GetBlogsByCategoryDto {
  final String categoryId;

  GetBlogsByCategoryDto(this.categoryId);
}

class GetBlogsByCategoryUseCase
    extends IUseCase<GetBlogsByCategoryDto, List<Blog>> {
  final IBlogRepository blogRepository;

  GetBlogsByCategoryUseCase(this.blogRepository);

  @override
  Future<Result<List<Blog>>> execute(GetBlogsByCategoryDto dto) async {
    return await blogRepository.getBlogsByCategory(dto.categoryId);
  }
}
