part of 'popular_blogs_bloc.dart';

sealed class PopularBlogsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class PopularBlogsLoading extends PopularBlogsState {}

class PopularBlogsSuccess extends PopularBlogsState {
  final List<Blog> blogs;

  PopularBlogsSuccess({required this.blogs});

  @override
  List<Object> get props => [blogs];
}

class PopularBlogsFailed extends PopularBlogsState {
  final String message;

  PopularBlogsFailed({required this.message});

  @override
  List<Object> get props => [message];
}
