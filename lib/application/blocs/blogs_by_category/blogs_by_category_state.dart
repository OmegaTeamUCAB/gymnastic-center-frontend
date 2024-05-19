part of 'blogs_by_category_bloc.dart';

sealed class BlogsByCategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class BlogsByCategoryLoading extends BlogsByCategoryState {}

class BlogsByCategorySuccess extends BlogsByCategoryState {
  final List<Blog> blogs;

  BlogsByCategorySuccess({required this.blogs});

  @override
  List<Object> get props => [blogs];
}

class BlogsByCategoryFailed extends BlogsByCategoryState {
  final String message;

  BlogsByCategoryFailed({required this.message});

  @override
  List<Object> get props => [message];
}
