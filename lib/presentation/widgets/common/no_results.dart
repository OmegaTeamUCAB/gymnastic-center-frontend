import 'package:flutter/material.dart';

class NoResults extends StatelessWidget {
  final String message;
  const NoResults({super.key, this.message = 'No results found'});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/triste.png',
          height: 70,
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        ),
        const SizedBox(height: 12),
        Text(
          message,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)),
        ),
        Text(
          'Try looking somewhere else or come back later.',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)),
        )
      ],
    );
  }
}
