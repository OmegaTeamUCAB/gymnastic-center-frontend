import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';

class GetAllBlogsDto {
  GetAllBlogsDto();
}

class GetAllBlogsUseCase extends IUseCase<GetAllBlogsDto, List<Blog>> {
  final IBlogRepository categoryRepository;

  GetAllBlogsUseCase(this.categoryRepository);

  @override
  Future<Result<List<Blog>>> execute(GetAllBlogsDto dto) async {
    return await categoryRepository.getAllBlogs();
  }
}
