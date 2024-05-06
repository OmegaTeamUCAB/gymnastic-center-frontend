import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StatisticsScreen extends StatelessWidget {
  static const name = 'statistics_screen';

  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        titleTextStyle: const TextStyle(fontSize: 20),
        backgroundColor: ThemeData().primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}
