import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';

class NoteView extends StatelessWidget {
  const NoteView({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surfaceTint,
      ),
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            lesson.content ?? '',
            style:
                Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
