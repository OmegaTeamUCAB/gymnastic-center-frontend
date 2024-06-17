import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'select_data_source_event.dart';
part 'select_data_source_state.dart';

class SelectDataSourceBloc
    extends Bloc<SelectDataSourceEvent, SelectDataSourceState> {
  SelectDataSourceBloc() : super(const SelectDataSourceState()) {
    on<SelectedDataSource>(_onSelectDataSource);
  }

  void _onSelectDataSource(
      SelectedDataSource event, Emitter<SelectDataSourceState> emit) {
    emit(state.copyWith(selectedDataSource: event.selectedDataSource));
  }
}
