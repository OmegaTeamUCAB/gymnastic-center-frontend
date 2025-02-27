import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';

class LessonListView extends StatelessWidget {
  final List<Lesson> lessons;
  final int currentIndexLesson;
  final Function(int) onTap;

  const LessonListView({
    super.key,
    required this.lessons,
    required this.currentIndexLesson,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return InkWell(
            onTap: () {
              onTap(index);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (index == currentIndexLesson)
                    ? Theme.of(context).colorScheme.surfaceTint
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.title,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      (lesson.videoUrl != null)
                          ? Icons.play_arrow
                          : (lesson.imageUrl == null)
                              ? Icons.note_add_rounded
                              : Icons.image_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
