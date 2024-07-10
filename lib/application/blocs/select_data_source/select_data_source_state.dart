part of 'select_data_source_bloc.dart';

class SelectDataSourceState extends Equatable {
  final int dataSourceIndex;
  final String dataSourceLetter;
  const SelectDataSourceState(
      {this.dataSourceIndex = 0, this.dataSourceLetter = 'Ω'});

  SelectDataSourceState copyWith(
          {int? dataSourceIndex, String? dataSourceLetter}) =>
      SelectDataSourceState(
        dataSourceIndex: dataSourceIndex ?? this.dataSourceIndex,
        dataSourceLetter: dataSourceLetter ?? this.dataSourceLetter,
      );

  @override
  List<Object> get props => [dataSourceIndex, dataSourceLetter];
}
