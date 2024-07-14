part of 'like_or_dislike_comment_bloc.dart';

sealed class LikeOrDislikeCommentState extends Equatable {
  @override
  List<Object> get props => [];
}

class LikeOrDislikeCommentLoading extends LikeOrDislikeCommentState {}

class LikeOrDislikeCommentSuccess extends LikeOrDislikeCommentState {}

class LikeOrDislikeCommentFailed extends LikeOrDislikeCommentState {
  final String message;

  LikeOrDislikeCommentFailed({required this.message});

  @override
  List<Object> get props => [message];
}
