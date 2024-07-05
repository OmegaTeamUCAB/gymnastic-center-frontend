import 'package:flutter/material.dart';

class BrandFooter extends StatelessWidget {
  const BrandFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Designed and developed by Omega Technologies \u00a9',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 12, color: Theme.of(context).colorScheme.onSecondary),
    );
  }
}
