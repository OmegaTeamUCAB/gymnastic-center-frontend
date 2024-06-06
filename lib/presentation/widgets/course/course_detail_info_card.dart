import 'package:flutter/material.dart';

class CourseDetailInfoCard extends StatelessWidget {
  final IconData iconData;
  final String label;

  final onPressed;
  const CourseDetailInfoCard({
    super.key,
    required this.iconData,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surfaceTint,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Icon(iconData, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
