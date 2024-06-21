import 'dart:convert';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
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
  Future<Result<List<Comment>>> getComments(GetCommentsDto dto) async {
    var queryParameters = {
      'page': dto.page.toString(),
      'perPage': '15',
      if (dto.blogId != null) 'blog': dto.blogId.toString(),
      if (dto.lessonId != null) 'lesson': dto.lessonId.toString(),
    };

    var queryString = Uri(queryParameters: queryParameters).query;
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'comment/many?$queryString',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Comment> comments = [];
        for (var comment in data) {
          comments.add(Comment(
            id: comment['id'],
            user: comment['user'],
            body: comment['body'],
            countLikes: comment['countLikes'],
            countDislikes: comment['countDislikes'],
            userDisliked: comment['userDisliked'],
            userLiked: comment['userDisliked'],
            date: comment['date'],
          ));
        }
        return comments;
      },
    );
    return result;
  }

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
        return CreateCommentResponse.fromJson(data);
      },
    );
    return result;
  }

  @override
  Future<Result<ICreateCommentResponse>> createBlogComment({
    required String userId,
    required String content,
    required String blogId,
  }) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'blog/create-comment',
      httpMethod: 'POST',
      body: jsonEncode({
        'userId': userId,
        'content': content,
        'blogId': blogId,
      }),
      mapperCallBack: (data) {
        return CreateCommentResponse.fromJson(data);
      },
    );
    return result;
  }

  @override
  Future<Result<ICreateCommentResponse>> likeOrDislikeCommentById({
    required String commentId,
    required bool like,
  }) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: like ? 'comment/toggle/like' : 'comment/toggle/dislike',
      httpMethod: 'POST',
      body: jsonEncode({
        'commentId': commentId,
      }),
      mapperCallBack: (data) {
        return CreateCommentResponse.fromJson(data);
      },
    );
    return result;
  }
}
