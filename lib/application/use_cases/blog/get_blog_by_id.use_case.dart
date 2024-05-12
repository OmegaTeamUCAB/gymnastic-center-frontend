import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';

class GetBlogByIdDto {
  final String blogId;

  GetBlogByIdDto(this.blogId);
}

class GetBlogByIdUseCase extends IUseCase<GetBlogByIdDto, Blog> {
  final IBlogRepository blogRepository;

  GetBlogByIdUseCase(this.blogRepository);

  @override
  Future<Result<Blog>> execute(GetBlogByIdDto dto) async {
    return await blogRepository.getBlogById(dto.blogId);
  }
}
