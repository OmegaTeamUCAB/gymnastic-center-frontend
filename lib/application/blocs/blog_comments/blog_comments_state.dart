part of 'blog_comments_bloc.dart';

sealed class BlogCommentsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class BlogCommentsLoading extends BlogCommentsState {}

class BlogCommentsSuccess extends BlogCommentsState {
  final List<Comment> comments;

  BlogCommentsSuccess({required this.comments});

  @override
  List<Object> get props => [comments];
}

class BlogCommentsFailed extends BlogCommentsState {
  final String message;

  BlogCommentsFailed({required this.message});

  @override
  List<Object> get props => [message];
}
