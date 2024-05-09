part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String queryString;
  final Set<String> filters;
  final List<Course> results;
  const SearchState(
      {this.queryString = '',
      this.filters = const {},
      this.results = const []});

  SearchState copyWith({
    String? queryString,
    Set<String>? filters,
    List<Course>? results,
  }) =>
      SearchState(
        queryString: queryString ?? this.queryString,
        filters: filters ?? this.filters,
        results: results ?? this.results,
      );
  @override
  List<Object> get props => [queryString, filters, results];
}
