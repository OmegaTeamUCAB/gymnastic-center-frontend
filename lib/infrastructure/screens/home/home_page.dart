import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_app_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 230), child: HomeAppBar()),
      body: Placeholder(),
    );
  }
}
