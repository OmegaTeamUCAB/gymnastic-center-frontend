part of 'create_comment_bloc.dart';

sealed class CreateCommentState extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateCommentLoading extends CreateCommentState {}

class CreateCommentFailed extends CreateCommentState {
  final String message;

  CreateCommentFailed({required this.message});

  @override
  List<Object> get props => [message];
}
