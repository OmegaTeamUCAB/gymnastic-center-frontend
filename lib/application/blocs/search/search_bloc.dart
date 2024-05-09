import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/domain/course/course.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<QueryStringChanged>(_onQueryStringChange);
    on<FilterSelected>(_onFilterSelect);
    on<FilterDeselected>(_onFilterDeselect);
  }

  void _onQueryStringChange(
      QueryStringChanged event, Emitter<SearchState> emit) {
    emit(state.copyWith(queryString: event.queryString));
  }

  void _onFilterSelect(FilterSelected event, Emitter<SearchState> emit) {
    emit(state.copyWith(filters: {...state.filters, event.selectedFilter}));
  }

  void _onFilterDeselect(FilterDeselected event, Emitter<SearchState> emit) {
    emit(state.copyWith(
        filters: {...state.filters}..remove(event.deselectedFilter)));
  }
}
