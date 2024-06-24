part of 'get_search_tags_bloc.dart';

sealed class GetSearchTagsEvent {
  const GetSearchTagsEvent();
}

class SearchTagsRequested extends GetSearchTagsEvent {
  const SearchTagsRequested();
}
