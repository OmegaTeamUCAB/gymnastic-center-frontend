part of 'get_search_tags_bloc.dart';

sealed class GetSearchTagsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SearchTagsLoading extends GetSearchTagsState {}

class GetSearchTagsSuccess extends GetSearchTagsState {
  //TODO: Add search tags type
  final List<dynamic> searchTags;

  GetSearchTagsSuccess({required this.searchTags});

  @override
  List<Object> get props => [searchTags];
}

class GetSearchTagsFailed extends GetSearchTagsState {
  final String message;

  GetSearchTagsFailed({required this.message});

  @override
  List<Object> get props => [message];
}
