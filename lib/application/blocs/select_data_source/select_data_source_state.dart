part of 'select_data_source_bloc.dart';

class SelectDataSourceState extends Equatable {
  final int dataSourceIndex;
  const SelectDataSourceState({this.dataSourceIndex = 0});

  SelectDataSourceState copyWith({
    int? dataSourceIndex,
  }) =>
      SelectDataSourceState(
        dataSourceIndex: dataSourceIndex ?? this.dataSourceIndex,
      );

  @override
  List<Object> get props => [dataSourceIndex];
}
