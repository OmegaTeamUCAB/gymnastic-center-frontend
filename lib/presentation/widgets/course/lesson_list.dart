import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/progress/progress_bloc.dart';
import 'package:gymnastic_center/domain/lesson/lesson.dart';
import 'package:gymnastic_center/presentation/screens/course/lesson_tile_info.dart';

class LessonList extends StatelessWidget {
  final List<Lesson> lessons;
  final void Function(int) onTap;
  const LessonList({super.key, required this.lessons, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final lessonBloc = context.watch<LessonBloc>();
    final lessonProgress =
        context.watch<ProgressBloc>().state.progress.lessonProgress;

    return BlocBuilder<ProgressBloc, ProgressState>(
      builder: (context, state) {
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
                child: InkWell(
                  onTap: () {
                    onTap(index);
                  },
                  child: LessonTile(
                    lesson: lesson,
                    lessonProgress: (lessonProgress.isEmpty)
                        ? null
                        : lessonProgress.elementAt(index),
                    selected: lessonBloc.state.lesson.id == lesson.id,
                  ),
                ),
              );
            });
      },
    );
  }
}
