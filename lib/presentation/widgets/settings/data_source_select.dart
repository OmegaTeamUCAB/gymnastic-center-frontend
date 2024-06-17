import 'package:flutter/material.dart';

List<dynamic> dataSources = [
  {
    'name': 'Omega',
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

class DataSourceSelect extends StatefulWidget {
  const DataSourceSelect({super.key});

  @override
  State<DataSourceSelect> createState() => _DataSourceSelectState();
}

class _DataSourceSelectState extends State<DataSourceSelect> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: dataSources.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataSources[index]['name']),
                tileColor: index == selectedIndex
                    ? Theme.of(context).colorScheme.surfaceTint
                    : Theme.of(context).colorScheme.background,
                titleTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    Navigator.of(context).pop();
                  });
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
