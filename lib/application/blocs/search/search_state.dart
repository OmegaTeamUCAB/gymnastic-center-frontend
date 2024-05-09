part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String searchTerm;
  final Set<String> filters;
  final List<Course> results;
  const SearchState(
      {this.searchTerm = '', this.filters = const {}, this.results = const []});

  SearchState copyWith({
    String? searchTerm,
    Set<String>? filters,
    List<Course>? results,
  }) =>
      SearchState(
        searchTerm: searchTerm ?? this.searchTerm,
        filters: filters ?? this.filters,
        results: results ?? this.results,
      );
  @override
  List<Object> get props => [searchTerm, filters, results];
}
