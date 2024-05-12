part of 'blog_detail_bloc.dart';

sealed class BlogDetailEvent {
  const BlogDetailEvent();
}

class BlogDetailRequested extends BlogDetailEvent {
  final String blogId;

  BlogDetailRequested({required this.blogId});
}
