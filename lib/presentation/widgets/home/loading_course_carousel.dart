import 'package:flutter/material.dart';

class LoadingCourseCarousel extends StatelessWidget {
  const LoadingCourseCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const Divider(),
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
