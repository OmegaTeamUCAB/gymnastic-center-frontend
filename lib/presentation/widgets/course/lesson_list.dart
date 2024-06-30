import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';
import 'package:gymnastic_center/presentation/screens/course/lesson_screen.dart';

class LessonList extends StatelessWidget {
  final List<Lesson> lessons;
  const LessonList({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceTint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LessonScreen(lessonId: lesson.id)),
                );
              },
              title: Text(
                lesson.title,
                overflow: TextOverflow.ellipsis,
              ),
              titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
              subtitle: Text(
                lesson.content!,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.info_outline),
            ),
          );
        });
  }
}
