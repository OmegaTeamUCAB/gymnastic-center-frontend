part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String searchTerm;
  final bool isLoading;
  final Set<String> filters;
  final SearchResults results;
  const SearchState(
      {this.searchTerm = '',
      this.isLoading = false,
      this.filters = const {},
      this.results = const SearchResults()});

  SearchState copyWith({
    String? searchTerm,
    bool? isLoading,
    Set<String>? filters,
    SearchResults? results,
  }) =>
      SearchState(
        searchTerm: searchTerm ?? this.searchTerm,
        isLoading: isLoading ?? this.isLoading,
        filters: filters ?? this.filters,
        results: results ?? this.results,
      );
  @override
  List<Object> get props => [searchTerm, isLoading, filters, results];
}
