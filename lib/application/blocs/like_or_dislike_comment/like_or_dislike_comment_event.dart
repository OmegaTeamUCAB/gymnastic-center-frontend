part of 'like_or_dislike_comment_bloc.dart';

sealed class LikeOrDislikeCommentEvent {
  const LikeOrDislikeCommentEvent();
}

class LikeOrDislikeCommentRequested extends LikeOrDislikeCommentEvent {
  final String commentId;
  final bool like;

  const LikeOrDislikeCommentRequested(
      {required this.commentId, required this.like});
}
