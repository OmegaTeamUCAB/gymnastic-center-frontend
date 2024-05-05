import 'package:flutter/material.dart';

class CarouselHeader extends StatelessWidget {
  final String title;
  final VoidCallback onButtonPressed;

  const CarouselHeader(
      {super.key, required this.title, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: onButtonPressed,
            child: Text(
              'See all >',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
