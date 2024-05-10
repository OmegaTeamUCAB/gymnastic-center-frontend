import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/domain/search/search_results.dart';
import 'package:gymnastic_center/infrastructure/services/search/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchService searchService = SearchService();

  SearchBloc() : super(const SearchState()) {
    on<QueryStringChanged>(_onQueryStringChange);
    on<FilterSelected>(_onFilterSelect);
    on<FilterDeselected>(_onFilterDeselect);
  }

  void _onQueryStringChange(
      QueryStringChanged event, Emitter<SearchState> emit) async {
      emit(state.copyWith(searchTerm: event.searchTerm));
    
    if (state.searchTerm.isNotEmpty) {
    final results = await searchService.search(event.searchTerm);
      emit(state.copyWith(results: results));
    }
  }

  void _onFilterSelect(FilterSelected event, Emitter<SearchState> emit) {
    emit(state.copyWith(filters: {...state.filters, event.selectedFilter}));
  }

  void _onFilterDeselect(FilterDeselected event, Emitter<SearchState> emit) {
    emit(state.copyWith(
        filters: {...state.filters}..remove(event.deselectedFilter)));
  }
}
