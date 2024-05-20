part of 'create_comment_bloc.dart';

sealed class CreateCommentEvent {
  const CreateCommentEvent();
}

class CreatedBlogComment extends CreateCommentEvent {
  final String blogId;
  final String userId;
  final String content;

  const CreatedBlogComment(
      {required this.blogId, required this.userId, required this.content});
}

class CreatedCourseComment extends CreateCommentEvent {
  final String courseId;
  final String lessonId;
  final String userId;
  final String content;

  const CreatedCourseComment(
      {required this.courseId,
      required this.lessonId,
      required this.userId,
      required this.content});
}
