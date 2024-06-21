import 'package:flutter/material.dart';

class BrandBackButton extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;
  const BrandBackButton({super.key, this.color = Colors.white, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          size: 30,
        ),
        onPressed: onPressed ??
            () {
              Navigator.pop(context);
            },
        color: color);
  }
}
