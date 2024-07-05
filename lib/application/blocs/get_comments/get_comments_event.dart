part of 'get_comments_bloc.dart';

sealed class GetCommentsEvent {
  const GetCommentsEvent();
}

class CommentsRequested extends GetCommentsEvent {
  final int page;
  final String? blogId;
  const CommentsRequested({required this.page, this.blogId});
}
