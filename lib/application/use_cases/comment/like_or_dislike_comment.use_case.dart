import 'package:gymnastic_center/domain/comment/comment_repository.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';

class LikeOrDislikeCommentByIdDto {
  final String commentId;
  final bool like;

  LikeOrDislikeCommentByIdDto({required this.commentId, required this.like});
}

class LikeOrDislikeCommentUseCase
    extends IUseCase<LikeOrDislikeCommentByIdDto, ICreateCommentResponse> {
  final ICommentRepository commentRepository;

  LikeOrDislikeCommentUseCase(this.commentRepository);

  @override
  Future<Result<ICreateCommentResponse>> execute(
      LikeOrDislikeCommentByIdDto dto) async {
    final result = await commentRepository.likeOrDislikeCommentById(
      commentId: dto.commentId,
      like: dto.like,
    );
    if (result.isSuccessful) {
      return Result.success(result.unwrap());
    }
    return Result.failure(result.error);
  }
}
