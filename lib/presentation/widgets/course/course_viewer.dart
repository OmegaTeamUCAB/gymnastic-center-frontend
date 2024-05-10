import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';
import 'package:gymnastic_center/presentation/widgets/course/image_view.dart';
import 'package:gymnastic_center/presentation/widgets/course/note_view.dart';
import 'package:gymnastic_center/presentation/widgets/course/video_view.dart';

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
            ? VideoView(lesson: lesson)
            : (lesson.imageUrl != null)
                ? ImageView(lesson: lesson)
                : NoteView(lesson: lesson));
  }
}
