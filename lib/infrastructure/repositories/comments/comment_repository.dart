
import 'dart:convert';

import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/comment/comment_repository.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';

class CreateCommentResponse implements ICreateCommentResponse {
  @override
  final String id;

  CreateCommentResponse({required this.id});

  factory CreateCommentResponse.fromJson(Map<String, dynamic> json) {
    return CreateCommentResponse(
      id: json['id'],
    );
  }
}

class CommentRepository extends ICommentRepository {
  final IHttpManager _httpConnectionManager;

  CommentRepository(this._httpConnectionManager);

  @override
  Future<Result<ICreateCommentResponse>> createCourseComment({
    required String userId,
    required String content,
    required String courseId,
    required String lessonId,
  }) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'courses/comment',
      httpMethod: 'POST',
      body: jsonEncode({
        'userId': userId,
        'content': content,
        'courseId': courseId,
        'lessonId': lessonId,
      }),
      mapperCallBack: (data) {
        return .fromJson(data);
      },
    );
    return result;
  }

  @override
  Future<Result<ICreateCommentResponse>> createBlogComment({required String userId, required String content, required String blogId}) {
    // TODO: implement createBlogComment
    throw UnimplementedError();
  }
}
