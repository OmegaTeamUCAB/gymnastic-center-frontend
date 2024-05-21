import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/comment/comment_repository.dart';

class CreateCourseCommentDto {
  final String userId;
  final String courseId;
  final String lessonId;
  final String content;

  CreateCourseCommentDto({
    required this.userId,
    required this.content,
    required this.courseId,
    required this.lessonId,
  });
}

class CreateCourseCommentUseCase
    extends IUseCase<CreateCourseCommentDto, ICreateCommentResponse> {
  final ICommentRepository _commentRepository;

  CreateCourseCommentUseCase(
    this._commentRepository,
  );

  @override
  Future<Result<ICreateCommentResponse>> execute(
      CreateCourseCommentDto dto) async {
    final result = await _commentRepository.createCourseComment(
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
