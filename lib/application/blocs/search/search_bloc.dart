import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/repositories/search/search_results.dart';
import 'package:gymnastic_center/application/use_cases/search/search.use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase searchUseCase;
  SearchBloc(this.searchUseCase) : super(const SearchState()) {
    on<QueryStringChanged>(_onQueryStringChange);
    on<FilterSelected>(_onFilterSelect);
    on<FilterDeselected>(_onFilterDeselect);
  }

  void _onQueryStringChange(
      QueryStringChanged event, Emitter<SearchState> emit) async {
    emit(state.copyWith(searchTerm: event.searchTerm, isLoading: true));

    if (state.searchTerm.isNotEmpty) {
      final results = await searchUseCase
          .execute(SearchDto(state.searchTerm, state.filters, 1, 10));
      emit(state.copyWith(results: results.unwrap(), isLoading: false));
    }
  }

  void _onFilterSelect(FilterSelected event, Emitter<SearchState> emit) {
    List<String> updatedFilters = List.from(state.filters);
    updatedFilters.add(event.selectedFilter);
    emit(state.copyWith(filters: updatedFilters));
  }

  void _onFilterDeselect(FilterDeselected event, Emitter<SearchState> emit) {
    List<String> updatedFilters = List.from(state.filters);
    updatedFilters.remove(event.deselectedFilter);
    emit(state.copyWith(filters: updatedFilters));
  }
}
