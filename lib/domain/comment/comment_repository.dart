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

abstract class ICreateCommentResponse {
  final String id;

  ICreateCommentResponse({required this.id});
}

abstract class ICommentRepository {
  Future<Result<ICreateCommentResponse>> createBlogComment({
    required String userId,
    required String content,
    required String blogId,
  });
  Future<Result<ICreateCommentResponse>> createCourseComment({
    required String userId,
    required String content,
    required String courseId,
    required String lessonId,
  });
  Future<Result<List<Comment>>> getComments(GetCommentsDto dto);
}
