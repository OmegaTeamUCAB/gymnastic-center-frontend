part of 'create_comment_bloc.dart';

sealed class CreateCommentEvent {
  const CreateCommentEvent();
}

class CreatedComment extends CreateCommentEvent {
  final String lessonOrBlogId;
  final String content;
  final String targetType;

  const CreatedComment(
      {required this.lessonOrBlogId,
      required this.content,
      required this.targetType});
}
