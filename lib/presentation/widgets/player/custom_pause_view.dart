import 'package:flutter/material.dart';

class CustomPauseView extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomPauseView({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.3),
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 80,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ));
  }
}
