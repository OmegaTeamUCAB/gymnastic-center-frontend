part of 'get_search_tags_bloc.dart';

sealed class GetSearchTagsEvent {
  const GetSearchTagsEvent();
}

class SearchTagsRequested extends GetSearchTagsEvent {
  final int page;
  final int perPage;
  const SearchTagsRequested(this.page, this.perPage);
}
