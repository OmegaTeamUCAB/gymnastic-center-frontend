import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/blocs/select_data_source/select_data_source_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<dynamic> dataSources = [
  {
    'name': 'Omega (recommended)',
    'api': 'This is the Omega api',
  },
  {
    'name': 'Lambda',
    'api': 'This is the Lambda api',
  },
  {
    'name': 'Alfa',
    'api': 'This is the Alfa api',
  },
  {
    'name': 'Delta',
    'api': 'This is the Delta api',
  },
];

class DataSourceSelect extends StatelessWidget {
  const DataSourceSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSourceBloc = context.watch<SelectDataSourceBloc>();
    return SizedBox(
      height: 220,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: dataSources.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataSources[index]['name']),
                tileColor: index == dataSourceBloc.state.dataSourceIndex
                    ? Theme.of(context).colorScheme.surfaceTint
                    : Theme.of(context).colorScheme.background,
                titleTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                onTap: () {
                  dataSourceBloc.add(SelectedDataSource(index));
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          )),
    );
  }
}
