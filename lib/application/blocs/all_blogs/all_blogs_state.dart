part of 'all_blogs_bloc.dart';

sealed class AllBlogsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AllBlogsLoading extends AllBlogsState {}

class AllBlogsSuccess extends AllBlogsState {
  final List<Blog> blogs;

  AllBlogsSuccess({required this.blogs});

  @override
  List<Object> get props => [blogs];
}

class AllBlogsFailed extends AllBlogsState {
  final String message;

  AllBlogsFailed({required this.message});

  @override
  List<Object> get props => [message];
}
