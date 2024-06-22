import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';

class GetCommentsDto {
  final int page;
  final String? blogId;
  final String? lessonId;
  GetCommentsDto({
    required this.page,
    this.blogId,
    this.lessonId,
  });
}

class CreateCommentDto {
  final String lessonOrBlogId;
  final String targetType;
  final String content;

  CreateCommentDto({
    required this.content,
    required this.lessonOrBlogId,
    required this.targetType,
  });
}

abstract class ICreateCommentResponse {
  final String id;

  ICreateCommentResponse({required this.id});
}

abstract class ICommentRepository {
  Future<Result<ICreateCommentResponse>> createComment(CreateCommentDto dto);
  Future<Result<List<Comment>>> getComments(GetCommentsDto dto);
}
