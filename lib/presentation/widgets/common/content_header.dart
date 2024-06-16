import 'package:flutter/material.dart';

class ContentHeader extends StatelessWidget {
  final String title;
  final dynamic onPressed;
  const ContentHeader({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary),
          ),
          const Spacer(),
          TextButton(
            onPressed: onPressed,
            child: const Text(
              'Show all',
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
