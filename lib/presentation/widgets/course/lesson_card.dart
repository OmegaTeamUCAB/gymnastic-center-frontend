import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';
import 'package:gymnastic_center/infrastructure/screens/disability/video_player_screen.dart';

class CourseViewer extends StatelessWidget {
  final Lesson lesson;
  const CourseViewer({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: (lesson.videoUrl != null)
            ? _VideoView(lesson: lesson)
            : (lesson.imageUrl != null) 
            ? _ImageView(lesson: lesson)
            : _NoteView(lesson: lesson));
  }
}

class _ImageView extends StatelessWidget {
  const _ImageView({
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

class _VideoView extends StatelessWidget {
  const _VideoView({
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
        child: Center(
          child: IconButton(
            icon: Icon(
              Icons.play_circle_fill_outlined,
              color: Colors.deepPurple,
              size: 80,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(
                            videoUrl: '${lesson.videoUrl}',
                          )));
            },
          ),
        ),
      );
  }
}

class _NoteView extends StatelessWidget {
  const _NoteView({
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
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 15),
            ),
          ),
        ),
      );
  }
}
