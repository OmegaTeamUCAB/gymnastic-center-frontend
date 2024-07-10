import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';

part 'select_data_source_event.dart';
part 'select_data_source_state.dart';

class SelectDataSourceBloc
    extends Bloc<SelectDataSourceEvent, SelectDataSourceState> {
  SelectDataSourceBloc() : super(const SelectDataSourceState()) {
    on<SelectedDataSource>(_onSelectDataSource);
  }

  void _onSelectDataSource(
      SelectedDataSource event, Emitter<SelectDataSourceState> emit) async {
    const List<String> greekLetters = ['Ω', 'λ', 'α', 'Δ'];
    if (event.dataSourceIndex >= 0 &&
        event.dataSourceIndex < greekLetters.length) {
      final selectedLetter = greekLetters[event.dataSourceIndex];
      emit(state.copyWith(
          dataSourceIndex: event.dataSourceIndex,
          dataSourceLetter: selectedLetter));
    }

    await Environment.initEnvironment(this);
  }
}
