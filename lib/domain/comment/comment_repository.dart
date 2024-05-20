import 'package:gymnastic_center/core/result.dart';

abstract class ICommentResponse {
  final String id;

  ICommentResponse({required this.id});
}

abstract class ICommentRepository {
  Future<Result<ICommentResponse>> createComment({
    required String userId,
    required String content,
    String? courseId,
    String? lessonId,
    String? blogId,
  });
}
