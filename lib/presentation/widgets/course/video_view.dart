import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';
import 'package:gymnastic_center/infrastructure/screens/disability/video_player_screen.dart';

class VideoView extends StatelessWidget {
  const VideoView({
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
          icon: const Icon(
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
