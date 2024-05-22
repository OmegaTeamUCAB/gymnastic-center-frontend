import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/comment/comment_repository.dart';

class CreateBlogCommentDto {
  final String userId;
  final String blogId;
  final String content;

  CreateBlogCommentDto({
    required this.userId,
    required this.content,
    required this.blogId,
  });
}

class CreateBlogCommentUseCase
    extends IUseCase<CreateBlogCommentDto, ICreateCommentResponse> {
  final ICommentRepository _commentRepository;

  CreateBlogCommentUseCase(
    this._commentRepository,
  );

  @override
  Future<Result<ICreateCommentResponse>> execute(
      CreateBlogCommentDto dto) async {
    final result = await _commentRepository.createBlogComment(
      userId: dto.userId,
      blogId: dto.blogId,
      content: dto.content,
    );
    if (result.isSuccessful) {
      return Result.success(result.unwrap());
    }
    return Result.failure(result.error);
  }
}
