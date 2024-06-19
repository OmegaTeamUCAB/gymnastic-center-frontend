import 'package:flutter/material.dart';

class CustomSpeedOptions extends StatelessWidget {
  final double speed;
  const CustomSpeedOptions({required this.speed});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Text(
      '$speed',
      style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
    )));
  }
}