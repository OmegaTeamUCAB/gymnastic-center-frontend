part of 'search_bloc.dart';

sealed class SearchEvent {
  const SearchEvent();
}

class QueryStringChanged extends SearchEvent {
  final String queryString;
  const QueryStringChanged(this.queryString);
}

class FilterSelected extends SearchEvent {
  final dynamic selectedFilter;
  const FilterSelected(this.selectedFilter);
}

class FilterDeselected extends SearchEvent {
  final dynamic deselectedFilter;
  const FilterDeselected(this.deselectedFilter);
}
