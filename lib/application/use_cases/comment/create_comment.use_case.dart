import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/comment/comment_repository.dart';

class CreateCommentUseCase
    extends IUseCase<CreateCommentDto, ICreateCommentResponse> {
  final ICommentRepository _commentRepository;

  CreateCommentUseCase(
    this._commentRepository,
  );

  @override
  Future<Result<ICreateCommentResponse>> execute(CreateCommentDto dto) async {
    final result = await _commentRepository.createComment(dto);
    if (result.isSuccessful) {
      return Result.success(result.unwrap());
    }
    return Result.failure(result.error);
  }
}
