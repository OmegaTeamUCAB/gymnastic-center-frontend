part of 'popular_blogs_bloc.dart';

sealed class PopularBlogsEvent {
  const PopularBlogsEvent();
}

class PopularBlogsRequested extends PopularBlogsEvent {
  final int page;
  const PopularBlogsRequested(this.page);
}
