import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/comment/comment_repository.dart';

class CreateCommentDto {
  final String userId;
  final String? courseId;
  final String? lessonId;
  final String content;
  final String? blogId;

  CreateCommentDto({
    required this.userId,
    required this.content,
    this.courseId,
    this.lessonId,
    this.blogId,
  });
}

class CreateCommentUseCase
    extends IUseCase<CreateCommentDto, ICommentResponse> {
  final ICommentRepository _commentRepository;

  CreateCommentUseCase(
    this._commentRepository,
  );

  @override
  Future<Result<ICommentResponse>> execute(CreateCommentDto dto) async {
    final result = await _commentRepository.createComment(
      userId: dto.userId,
      courseId: dto.courseId,
      lessonId: dto.lessonId,
      content: dto.content,
    );
    if (result.isSuccessful) {
      return Result.success(result.unwrap());
    }
    return Result.failure(result.error);
  }
}
