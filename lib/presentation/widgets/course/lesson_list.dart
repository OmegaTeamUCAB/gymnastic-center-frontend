import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';

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
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              onTap: () {
                //navigate
              },
              title: Text(
                lesson.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
              subtitle: const Text('Some description or info'),
              trailing: const Icon(Icons.info_outline),
            ),
          );
        });
  }
}