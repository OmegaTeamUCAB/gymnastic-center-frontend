part of 'delete_comment_bloc.dart';

sealed class DeleteCommentState extends Equatable {
  const DeleteCommentState();
  
  @override
  List<Object> get props => [];
}

final class DeleteCommentLoading extends DeleteCommentState {}

class DeleteCommentSuccess extends DeleteCommentState{
  const DeleteCommentSuccess();
}

class DeleteCommentFailed extends DeleteCommentState {
  final String message;

  const DeleteCommentFailed({required this.message});

  @override
  List<Object> get props => [message];
}

