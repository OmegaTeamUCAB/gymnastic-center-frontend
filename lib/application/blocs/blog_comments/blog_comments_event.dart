part of 'blog_comments_bloc.dart';

sealed class BlogCommentsEvent {
  const BlogCommentsEvent();
}

class BlogCommentsRequested extends BlogCommentsEvent {
  final int page;
  final String blogId;
  const BlogCommentsRequested({required this.page, required this.blogId});
}
