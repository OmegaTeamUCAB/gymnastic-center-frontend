part of 'all_blogs_by_trainer_bloc.dart';

sealed class AllBlogsByTrainerState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AllBlogsByTrainerLoading extends AllBlogsByTrainerState {}

class AllBlogsByTrainerSuccess extends AllBlogsByTrainerState {
  final List<Blog> blogs;

  AllBlogsByTrainerSuccess({required this.blogs});

  @override
  List<Object> get props => [blogs];
}

class AllBlogsByTrainerFailed extends AllBlogsByTrainerState {
  final String message;

  AllBlogsByTrainerFailed({required this.message});

  @override
  List<Object> get props => [message];
}
