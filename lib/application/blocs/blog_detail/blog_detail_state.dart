part of 'blog_detail_bloc.dart';


sealed class BlogDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class BlogDetailLoading extends BlogDetailState {}

class BlogDetailLoaded extends BlogDetailState {
  final Blog blog;

  BlogDetailLoaded({required this.blog});

  @override
  List<Object> get props => [blog];
}

class BlogDetailFailed extends BlogDetailState {
  final String message;

  BlogDetailFailed({required this.message});

  @override
  List<Object> get props => [message];
}
