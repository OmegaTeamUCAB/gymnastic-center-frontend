import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';

class GetAllBlogsUseCase extends IUseCase<GetBlogsDto, List<Blog>> {
  final IBlogRepository blogRepository;

  GetAllBlogsUseCase(this.blogRepository);

  @override
  Future<Result<List<Blog>>> execute(GetBlogsDto dto) async {
    return await blogRepository.getBlogs(dto);
  }
}
