import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
import 'package:gymnastic_center/domain/comment/comment_repository.dart';

class GetCommentsUseCase extends IUseCase<GetCommentsDto, List<Comment>> {
  final ICommentRepository courseRepository;

  GetCommentsUseCase(this.courseRepository);

  @override
  Future<Result<List<Comment>>> execute(GetCommentsDto dto) async {
    return await courseRepository.getComments(dto);
  }
}
