import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/repositories/search/search_results.dart';
import 'package:gymnastic_center/infrastructure/repositories/search/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc(this.searchRepository) : super(const SearchState()) {
    on<QueryStringChanged>(_onQueryStringChange);
    on<FilterSelected>(_onFilterSelect);
    on<FilterDeselected>(_onFilterDeselect);
  }

  void _onQueryStringChange(
      QueryStringChanged event, Emitter<SearchState> emit) async {
    emit(state.copyWith(searchTerm: event.searchTerm, isLoading: true));

    if (state.searchTerm.isNotEmpty) {
      final results = await searchRepository.search(event.searchTerm);
      emit(state.copyWith(results: results, isLoading: false));
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
