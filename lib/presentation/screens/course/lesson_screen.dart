import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/progress/progress_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/screens/course/views/congratulations_screen.dart';
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
    final lessonBloc = GetIt.instance<LessonBloc>();
    // ignore: unused_local_variable
    final progressBloc = GetIt.instance<ProgressBloc>()
      ..add(LessonProgressRequested(courseId: lessonBloc.state.courseId));
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
    final progressBloc = GetIt.instance<ProgressBloc>();
    final videoBloc = GetIt.instance<VideoPlayerBloc>();

    return BlocListener<VideoPlayerBloc, VideoPlayerState>(
      listenWhen: (previous, current) => previous.videoStatus != PlayerStatus.streaming && current.videoStatus == PlayerStatus.completed,
      listener: (context, state) {
        if (state.videoStatus == PlayerStatus.completed) {
          final checkProgress = progressBloc.checkProgress(videoBloc.getVideoTotalDuration().inSeconds, videoBloc.state.position.inSeconds, lessonBloc.state.lesson.id);
          if(!progressBloc.isCompleted() && checkProgress == true){
            Navigator.push(
                          context,
                          MaterialPageRoute(

                            builder: (context) => CongratulationsScreen(
                                  courseId: lessonBloc.state.courseId,
                                ),
                          ),
                        );
          } else {
          if(!lessonBloc.state.lastLesson){
          progressBloc.add(ProgressLessonUpdated(
              courseId: lessonBloc.state.courseId,
              lessonId: lessonBloc.state.lesson.id,
              markAsCompleted: videoBloc.state.position.inSeconds ==
                  videoBloc.getVideoTotalDuration().inSeconds,
              time: videoBloc.state.position,
              totalTime: videoBloc.getVideoTotalDuration()));
          }

          lessonBloc.changeToNextLesson();

          }
        }
      },
      child: BlocBuilder<LessonBloc, LessonState>(
        buildWhen: (previous, current) => previous.lesson.id != current.lesson.id,
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: Stack(
                        children: [
                          BlocBuilder<ProgressBloc, ProgressState>(
                            builder: (context, state) {
                              if (state.progressStatus ==
                                  ProgressStatus.fetching) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Container(
                                  color: Colors.grey[200],
                                  child: SizedBox.expand(
                                      child: FadeIn(
                                        curve: Curves.easeIn,
                                        duration: Durations.long4,
                                        child: VideoPlayerView(
                                          videoId:
                                              lessonBloc.state.lesson.videoUrl!,
                                          time: Duration(
                                              seconds: (progressBloc.state
                                                          .progressStatus ==
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
                        ],
                      ),
                    ),
                    LessonInfo(
                        lessonBloc: lessonBloc,
                        lessonId: lessonBloc.state.lesson.id,
                        onTap: videoBloc.pause
                      ),

                  ],
                ),
              ],
            ),
          );
        },
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
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
