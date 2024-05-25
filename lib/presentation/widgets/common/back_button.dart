import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  final Color color;
  const BackButton({super.key, required this.color});

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
      color: Colors.white,
    );
  }
}
