import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/course/course.dart';

class CourseOptionPageView extends StatelessWidget {
  final Course course;
  const CourseOptionPageView({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 170),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                course.imageUrl,
                height: 260,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              course.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Una categoría  |  Nombre del entrenador',
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
            const SizedBox(height: 24),
            Text(
              'Descripción breve del curso',
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
          ],
        ));
  }
}
