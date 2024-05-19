import 'package:flutter/material.dart';

class NoResults extends StatelessWidget {
  const NoResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Image.asset(
            'assets/triste.png',
            height: 100,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(height: 12),
          const Text(
            'No results found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Try looking somewhere else or come back later.',
            style: TextStyle(),
          )
        ],
      ),
    );
  }
}
