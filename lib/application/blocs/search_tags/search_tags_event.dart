part of 'search_tags_bloc.dart';

sealed class SearchTagsEvent {
  const SearchTagsEvent();
}

class SearchTagsRequested extends SearchTagsEvent {
  const SearchTagsRequested();
}
