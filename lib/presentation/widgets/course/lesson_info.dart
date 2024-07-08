import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/presentation/screens/course/lesson_screen.dart';
import 'package:gymnastic_center/presentation/widgets/comment/comments_fab.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/course/show_questions_tile.dart';
import 'package:gymnastic_center/presentation/widgets/player/video_duration.dart';
import 'package:gymnastic_center/presentation/widgets/player/video_progress_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LessonInfo extends StatelessWidget {
  final LessonBloc lessonBloc;
  final LessonState state;
  final String lessonId;
  const LessonInfo(
      {super.key,
      required this.lessonBloc,
      required this.state,
      required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const VideoProgressBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VideoTitle(title: lessonBloc.state.lesson.title),
                  const VideoDuration(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BrandButton(
                      isSecondVariant: true,
                      text: AppLocalizations.of(context)!.prev,
                      width: 110,
                      onPressed: lessonBloc.changeToPreviousLesson),
                  BrandButton(
                      text: AppLocalizations.of(context)!.next,
                      width: 210,
                      onPressed: lessonBloc.changeToNextLesson)
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: ShowQuestionsTile(
                  lessonId: lessonId,
                ))
          ],
        ),
      ),
    );
  }
}
