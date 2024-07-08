import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/course_detail/course_detail_bloc.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/progress/progress_bloc.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';
import 'package:gymnastic_center/domain/progress/progress.dart';
import 'package:gymnastic_center/presentation/screens/course/lesson_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_progress_indicator.dart';

class LessonTile extends StatelessWidget {
  final Lesson lesson;
  final LessonProgress? lessonProgress;
  final bool selected;
  LessonTile(
      {super.key,
      required this.lesson,
      this.lessonProgress,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      onTap: (context.watch<ProgressBloc>().state.progressStatus == ProgressStatus.unitialized) ? null : () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LessonScreen(lessonId: lesson.id)),
        );
      },
      leading: (GetIt.instance<ProgressBloc>().state.progress.lessonProgress.isEmpty) ? null :  _MarkLessonIcon(
            iconData: Icons.check_box_outline_blank_sharp,
            marked: GetIt.instance<ProgressBloc>().getLessonById(lesson.id).percent == 100.0,
            onTap: (marked) async {
              GetIt.instance<ProgressBloc>().updateAndLoadProgress(ProgressLessonUpdated(
                  courseId: context.read<LessonBloc>().state.courseId,
                  lessonId: lesson.id,
                  markAsCompleted: !marked,
                  time:
                      Duration(seconds: (marked == false) ? 0 : GetIt.instance<ProgressBloc>().getLessonById(lesson.id).time),
                  totalTime: Duration.zero), context.read<LessonBloc>().state.courseId );
            },
          ),
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
      trailing: BlocBuilder<ProgressBloc, ProgressState>(
        buildWhen: (previous, current) =>
            previous.progress.percent != current.progress.percent,
        builder: (context, state) {
          return (lessonProgress == null)
              ? const Icon(Icons.info_outline)
              : FittedBox(
                  child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: lessonProgress!.percent),
                  duration: const Duration(milliseconds: 900),
                  builder: (context, double value, child) {
                    return CustomProgressIndicator(
                      percent: value,
                    );
                  },
                ));
        },
      ),
    );
  }
}

class _MarkLessonIcon extends StatelessWidget {
  final void Function(bool) onTap;
  final IconData iconData;
  final bool marked;

  const _MarkLessonIcon({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.marked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(marked);
      },
      child: Container(child: Icon(iconData)),
    );
  }
}