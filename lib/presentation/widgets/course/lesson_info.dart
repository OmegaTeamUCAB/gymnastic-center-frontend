import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/progress/progress_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/screens/course/lesson_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/course/description_tile.dart';
import 'package:gymnastic_center/presentation/widgets/course/show_questions_tile.dart';
import 'package:gymnastic_center/presentation/widgets/player/buttons/video_duration.dart';
import 'package:gymnastic_center/presentation/widgets/player/buttons/video_progress_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gymnastic_center/presentation/widgets/player/overlays/watch_video_overlay.dart';
import 'package:gymnastic_center/presentation/widgets/player/video_thumbnail.dart';

class LessonInfo extends StatelessWidget {
  final LessonBloc lessonBloc;
  final String lessonId;
  final void Function() onTap;
  const LessonInfo(
      {super.key,
      required this.lessonBloc,
      required this.onTap,
      required this.lessonId});

  void saveLessonProgress() {
    final lessonBloc = GetIt.instance<LessonBloc>();
    final videoBloc = GetIt.instance<VideoPlayerBloc>();
    final progressBloc = GetIt.instance<ProgressBloc>();
    if (videoBloc.state.videoStatus != PlayerStatus.loading) {
      progressBloc.updateAndLoadProgress(
          ProgressLessonUpdated(
              courseId: lessonBloc.state.courseId,
              lessonId: lessonBloc.state.lesson.id,
              markAsCompleted: videoBloc.state.position.inSeconds ==
                  videoBloc.getVideoTotalDuration().inSeconds,
              time: videoBloc.state.position,
              totalTime: videoBloc.getVideoTotalDuration()),
          lessonBloc.state.courseId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessonBloc = GetIt.instance<LessonBloc>();

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
                  Expanded(
                    flex: (!lessonBloc.state.firstLesson) ? 4 : 0,
                    child: BrandButton(
                        isSecondVariant: true,
                        text: AppLocalizations.of(context)!.prev,
                        width: (!lessonBloc.state.firstLesson) ? 110 : 0,
                        onPressed: () {
                          GetIt.instance<VideoPlayerBloc>().pause();
                          saveLessonProgress();
                          lessonBloc.changeToPreviousLesson();
                        }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: (!lessonBloc.state.lastLesson) ? 6 : 0,
                    child: BrandButton(
                      text: AppLocalizations.of(context)!.next,

                      width: (!lessonBloc.state.lastLesson) ? 210 : 0,
                      onPressed: () {
                        GetIt.instance<VideoPlayerBloc>().pause();
                        saveLessonProgress();
                        lessonBloc.changeToNextLesson();
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (!lessonBloc.state.lastLesson)
              _ComingUpCard(lessonBloc: lessonBloc),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: ShowQuestionsTile(lessonId: lessonId, onTap: onTap)),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: DescriptionTile(
                    description: lessonBloc.state.lesson.content,
                    onTap: onTap)),
          ],
        ),
      ),
    );
  }
}

class _ComingUpCard extends StatelessWidget {
  const _ComingUpCard({
    super.key,
    required this.lessonBloc,
  });

  final LessonBloc lessonBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: VideoThumbnailImage(
                          videoPath: lessonBloc.getNextLesson().videoUrl!,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    const WatchVideoOverlay()
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Coming up:'),
                    Text(context.watch<LessonBloc>().getNextLesson().title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
