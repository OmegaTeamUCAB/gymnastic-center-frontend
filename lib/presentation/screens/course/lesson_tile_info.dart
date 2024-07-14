import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/progress/progress_bloc.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';
import 'package:gymnastic_center/domain/progress/progress.dart';
import 'package:gymnastic_center/presentation/screens/course/lesson_screen.dart';

class LessonTile extends StatelessWidget {
  final Lesson lesson;
  final LessonProgress? lessonProgress;

  const LessonTile({
    super.key,
    required this.lesson,
    this.lessonProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (lessonProgress?.percent != 0)
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 15.0,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width *
                  (lessonProgress?.percent ?? 0) /
                  106.3,
            ),
          ),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            onTap: (context.watch<ProgressBloc>().state.progressStatus ==
                    ProgressStatus.unitialized)
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LessonScreen(lessonId: lesson.id)),
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: (GetIt.instance<ProgressBloc>()
                    .state
                    .progress
                    .lessonProgress
                    .isEmpty)
                ? null
                : _MarkLessonIcon(
                    iconUnmarked: Icons.check_box_outline_blank_sharp,
                    iconMarked: Icons.check_circle_rounded,
                    marked: GetIt.instance<ProgressBloc>()
                            .getLessonById(lesson.id)
                            .percent ==
                        100.0,
                    onTap: (marked) async {
                      GetIt.instance<ProgressBloc>().updateAndLoadProgress(
                          ProgressLessonUpdated(
                              courseId:
                                  context.read<LessonBloc>().state.courseId,
                              lessonId: lesson.id,
                              markAsCompleted: !marked,
                              time: Duration(
                                  seconds: (marked == false)
                                      ? 0
                                      : GetIt.instance<ProgressBloc>()
                                          .getLessonById(lesson.id)
                                          .time),
                              totalTime: Duration.zero),
                          context.read<LessonBloc>().state.courseId);
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

class _MarkLessonIcon extends StatelessWidget {
  final void Function(bool) onTap;
  final IconData iconMarked;
  final IconData iconUnmarked;
  final bool marked;

  const _MarkLessonIcon({
    super.key,
    required this.onTap,
    required this.iconMarked,
    required this.iconUnmarked,
    required this.marked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(marked);
      },
      child: Container(child: Icon((marked) ? iconMarked : iconUnmarked)),
    );
  }
}
