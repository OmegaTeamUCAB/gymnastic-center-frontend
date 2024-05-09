part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String searchTerm;
  final Set<String> filters;
  final SearchResults results;
  const SearchState(
      {this.searchTerm = '',
      this.filters = const {},
      this.results = const SearchResults()});

  SearchState copyWith({
    String? searchTerm,
    Set<String>? filters,
    SearchResults? results,
  }) =>
      SearchState(
        searchTerm: searchTerm ?? this.searchTerm,
        filters: filters ?? this.filters,
        results: results ?? this.results,
      );
  @override
  List<Object> get props => [searchTerm, filters, results];
}
