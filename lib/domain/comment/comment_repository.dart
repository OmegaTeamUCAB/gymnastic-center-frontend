import 'package:gymnastic_center/core/result.dart';

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
}
