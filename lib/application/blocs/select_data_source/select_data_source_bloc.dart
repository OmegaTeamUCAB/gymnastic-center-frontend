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
    emit(state.copyWith(dataSourceIndex: event.dataSourceIndex));
    await Environment.initEnvironment(this);
  }
}
