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
      urlPath: 'comment/many?$queryString&sort=LIKES',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Comment> comments = [];
        for (var comment in data) {
          Answer? answer;
          if (comment['answer'] != null) {
            answer = Answer(
              id: comment['answer']['id'],
              trainerId: comment['answer']['instructor']['id'],
              trainerName: comment['answer']['instructor']['name'],
              trainerImage: comment['answer']['instructor']['image'],
              body: comment['answer']['answer'],
              date: DateTime.parse(comment['answer']['date']),
            );
          }
          comments.add(Comment(
            id: comment['id'],
            user: comment['user'],
            userId: comment['userId'],
            userImage: comment['userImage'],
            body: comment['body'],
            countLikes: comment['countLikes'],
            countDislikes: comment['countDislikes'],
            userDisliked: comment['userDisliked'],
            userLiked: comment['userLiked'],
            date: DateTime.parse(comment['date']),
            answer: answer, // This can be null if the comment has no answer
          ));
        }
        return comments;
      },
    );
    return result;
  }

  @override
  Future<Result<ICreateCommentResponse>> createComment(
      CreateCommentDto dto) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'comment/release',
      httpMethod: 'POST',
      body: jsonEncode({
        'body': dto.content,
        'target': dto.lessonOrBlogId,
        'targetType': dto.targetType,
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
      urlPath: like
          ? 'comment/toggle/like/$commentId'
          : 'comment/toggle/dislike/$commentId',
      httpMethod: 'POST',
      mapperCallBack: (data) {
        return CreateCommentResponse.fromJson(data);
      },
    );
    return result;
  }

  @override
  Future<Result<void>> deleteComment(String commentId) async {
    final result = await _httpConnectionManager.makeRequest(
        httpMethod: 'DELETE',
        urlPath: 'comment/delete/$commentId',
        mapperCallBack: (_) => {});
    return result;
  }
}
