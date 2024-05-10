import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        '${lesson.imageUrl}',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
