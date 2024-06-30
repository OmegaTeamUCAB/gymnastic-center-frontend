part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String searchTerm;
  final bool isLoading;
  final bool isSubmitted;
  final List<String> filters;
  final SearchResults results;
  const SearchState(
      {this.searchTerm = '',
      this.isLoading = false,
      this.isSubmitted = false,
      this.filters = const [],
      this.results = const SearchResults()});

  SearchState copyWith({
    String? searchTerm,
    bool? isLoading,
    bool? isSubmitted,
    List<String>? filters,
    SearchResults? results,
  }) =>
      SearchState(
        searchTerm: searchTerm ?? this.searchTerm,
        isLoading: isLoading ?? this.isLoading,
        isSubmitted: isSubmitted ?? this.isSubmitted,
        filters: filters ?? this.filters,
        results: results ?? this.results,
      );
  @override
  List<Object> get props =>
      [searchTerm, isLoading, isSubmitted, filters, results];
}
