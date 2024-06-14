part of 'all_blogs_bloc.dart';

sealed class AllBlogsEvent {
  const AllBlogsEvent();
}

class AllBlogsRequested extends AllBlogsEvent {
  final int page;
  const AllBlogsRequested(this.page);
}
