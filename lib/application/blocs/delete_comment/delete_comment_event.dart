part of 'delete_comment_bloc.dart';

sealed class DeleteCommentEvent{}

class DeleteRequested extends DeleteCommentEvent {
  final String id;

  DeleteRequested({required this.id});
}

