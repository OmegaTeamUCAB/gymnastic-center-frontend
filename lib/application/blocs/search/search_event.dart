part of 'search_bloc.dart';

sealed class SearchEvent {
  const SearchEvent();
}

class QueryStringChanged extends SearchEvent {
  final String searchTerm;
  const QueryStringChanged(this.searchTerm);
}

class FormSubmitted extends SearchEvent {
  const FormSubmitted();
}

class FilterSelected extends SearchEvent {
  final dynamic selectedFilter;
  const FilterSelected(this.selectedFilter);
}

class FilterDeselected extends SearchEvent {
  final dynamic deselectedFilter;
  const FilterDeselected(this.deselectedFilter);
}
