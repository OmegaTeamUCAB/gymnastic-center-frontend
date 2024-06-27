part of 'search_tags_bloc.dart';

sealed class SearchTagsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SearchTagsLoading extends SearchTagsState {}

class SearchTagsSuccess extends SearchTagsState {
  final List<String> searchTags;

  SearchTagsSuccess({required this.searchTags});

  @override
  List<Object> get props => [searchTags];
}

class SearchTagsFailed extends SearchTagsState {
  final String message;

  SearchTagsFailed({required this.message});

  @override
  List<Object> get props => [message];
}
