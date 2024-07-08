import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/progress/progress_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/course/lesson_info.dart';
import 'package:gymnastic_center/presentation/widgets/player/video_player_preview.dart';

class LessonScreen extends StatefulWidget {
  final String lessonId;

  LessonScreen({
    super.key,
    required this.lessonId,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  void initState() {
    super.initState();
    GetIt.instance<LessonBloc>()
        .add(ChangeLessonById(lessonId: widget.lessonId));
  }

  @override
  void dispose() {
    saveProgress();
    GetIt.instance<VideoPlayerBloc>().setToInitialState();
    super.dispose();
  }

  void saveProgress() {
    final lessonBloc = GetIt.instance<LessonBloc>();
    final videoBloc = GetIt.instance<VideoPlayerBloc>();
    final progressBloc = GetIt.instance<ProgressBloc>();
    if (GetIt.instance<VideoPlayerBloc>().state.videoStatus !=
        PlayerStatus.loading) {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: GetIt.instance<LessonBloc>()),
        BlocProvider.value(value: GetIt.instance<VideoPlayerBloc>()),
        BlocProvider.value(value: GetIt.instance<ProgressBloc>())
      ],
      child: _LessonView(
        lessonId: widget.lessonId,
      ),
    );
  }
}

class _LessonView extends StatefulWidget {
  final String lessonId;
  const _LessonView({
    required this.lessonId,
  });

  @override
  State<_LessonView> createState() => _LessonViewState();
}

class _LessonViewState extends State<_LessonView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lessonBloc = GetIt.instance<LessonBloc>();
    final progressBloc = GetIt.instance<ProgressBloc>()
      ..add(LessonProgressRequested(courseId: lessonBloc.state.courseId));
    final videoBloc = GetIt.instance<VideoPlayerBloc>();

    return BlocListener<VideoPlayerBloc, VideoPlayerState>(
      listener: (context, state) {
        if(state.videoStatus == PlayerStatus.completed){
                progressBloc.add(ProgressLessonUpdated(
          courseId: lessonBloc.state.courseId,
          lessonId: lessonBloc.state.lesson.id,
          markAsCompleted: videoBloc
                  .state.position.inSeconds ==
              videoBloc.getVideoTotalDuration().inSeconds,
          time: videoBloc.state.position,
          totalTime: videoBloc.getVideoTotalDuration()));

          lessonBloc.changeToNextLesson();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      BlocBuilder<ProgressBloc, ProgressState>(
                        builder: (context, state) {
                          if (state.progressStatus == ProgressStatus.fetching) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Container(
                              color: Colors.grey[200],
                              child: SizedBox(
                                  width: 600,
                                  height: 600,
                                  child: FadeIn(
                                    curve: Curves.easeIn,
                                    duration: Durations.long4,
                                    child: VideoPlayerView(
                                      videoId:
                                          lessonBloc.state.lesson.videoUrl!,
                                      time: Duration(
                                          seconds: (progressBloc
                                                      .state.progressStatus ==
                                                  ProgressStatus.loaded)
                                              ? progressBloc
                                                  .getLessonById(lessonBloc
                                                      .state.lesson.id)
                                                  .time
                                              : 0),
                                    ),
                                  )),
                            );
                          }
                        },
                      ),
                      Positioned(
                        top: 60,
                        right: 10,
                        child: IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white, size: 30),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: VideoProgressBar(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                        isVariant: true,
                        text: 'Prev',
                        width: 110,
                        onPressed: () {
                          if (videoBloc.state.videoStatus !=
                              PlayerStatus.loading) {
                            progressBloc.add(ProgressLessonUpdated(
                                courseId: lessonBloc.state.courseId,
                                lessonId: lessonBloc.state.lesson.id,
                                markAsCompleted: videoBloc
                                        .state.position.inSeconds ==
                                    videoBloc.getVideoTotalDuration().inSeconds,
                                time: videoBloc.state.position,
                                totalTime: videoBloc.getVideoTotalDuration()));
                          }
                          lessonBloc.changeToPreviousLesson();
                        },
                      ),
                      BrandButton(
                        text: 'Next',
                        width: 210,
                        onPressed: () {
                          if (context
                                  .read<VideoPlayerBloc>()
                                  .state
                                  .videoStatus !=
                              PlayerStatus.loading) {
                            progressBloc.add(ProgressLessonUpdated(
                                courseId: lessonBloc.state.courseId,
                                lessonId: lessonBloc.state.lesson.id,
                                markAsCompleted: videoBloc
                                        .state.position.inSeconds ==
                                    videoBloc.getVideoTotalDuration().inSeconds,
                                time: videoBloc.state.position,
                                totalTime: videoBloc.getVideoTotalDuration()));
                          }

                          lessonBloc.changeToNextLesson();
                        },
                      )
                    ],
                  ),
                ),
                !lessonBloc.state.lastLesson
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    lessonBloc.state.courseImage,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Coming up:'),
                                      Text(
                                          context
                                              .watch<LessonBloc>()
                                              .getNextLesson()
                                              .title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      Text('0:30',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            Positioned(
                bottom: 20,
                right: 20,
                child: CommentsCourseFAB(
                  lessonId: widget.lessonId,
                ))
          ],
        ),
      ),
    );
  }
}

class VideoTitle extends StatelessWidget {
  final String title;

  const VideoTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
