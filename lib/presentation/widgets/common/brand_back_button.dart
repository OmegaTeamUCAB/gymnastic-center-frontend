import 'package:flutter/material.dart';

class BrandBackButton extends StatelessWidget {
  final Color color;
  const BrandBackButton({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        color: color);
  }
}
