import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';

class GetAllBlogsByTrainerDto {
  final int page;
  final String trainerId;

  GetAllBlogsByTrainerDto(this.page, this.trainerId);
}

class GetAllBlogsByTrainerUseCase
    extends IUseCase<GetAllBlogsByTrainerDto, List<Blog>> {
  @override
  Future<Result<List<Blog>>> execute(GetAllBlogsByTrainerDto dto) {
    // TODO: implement execute
    throw UnimplementedError();
  }
  // final IBlogRepository blogRepository;
}
