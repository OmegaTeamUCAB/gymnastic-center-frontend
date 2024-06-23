part of 'get_comments_bloc.dart';

sealed class GetCommentsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetCommentsLoading extends GetCommentsState {}

class GetCommentsSuccess extends GetCommentsState {
  final List<Comment> comments;

  GetCommentsSuccess({required this.comments});

  @override
  List<Object> get props => [comments];
}

class GetCommentsFailed extends GetCommentsState {
  final String message;

  GetCommentsFailed({required this.message});

  @override
  List<Object> get props => [message];
}
