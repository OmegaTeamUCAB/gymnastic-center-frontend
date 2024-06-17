part of 'select_data_source_bloc.dart';

class SelectDataSourceState extends Equatable {
  final int selectedDataSource;
  const SelectDataSourceState({this.selectedDataSource = 0});

  SelectDataSourceState copyWith({
    int? selectedDataSource,
  }) =>
      SelectDataSourceState(
        selectedDataSource: selectedDataSource ?? this.selectedDataSource,
      );

  @override
  List<Object> get props => [selectedDataSource];
}
