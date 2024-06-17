part of 'select_data_source_bloc.dart';

sealed class SelectDataSourceEvent {
  const SelectDataSourceEvent();
}

class SelectedDataSource extends SelectDataSourceEvent {
  final int selectedDataSource;
  const SelectedDataSource(this.selectedDataSource);
}
