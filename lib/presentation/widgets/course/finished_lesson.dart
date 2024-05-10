import 'package:flutter/material.dart';

class FinishedLesson extends StatelessWidget {
  const FinishedLesson({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Lección completada',
            style: TextStyle(fontSize: 30, color: Colors.white)),
        Center(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 60,
            ),
          ),
        )
      ],
    ));
  }
}
