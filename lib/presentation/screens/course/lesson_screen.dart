import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/course/lesson_info.dart';
import 'package:gymnastic_center/presentation/widgets/player/video_player_preview.dart';

class LessonScreen extends StatefulWidget {
  final String lessonId;

  const LessonScreen({
    super.key,
    required this.lessonId,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late VideoPlayerBloc videoPlayerBloc;

  @override
  void initState() {
    super.initState();
    videoPlayerBloc = VideoPlayerBloc();
  }

  @override
  void dispose() {
    videoPlayerBloc.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: GetIt.instance<LessonBloc>()),
          BlocProvider.value(
            value: videoPlayerBloc,
          )
        ],
        child: _LessonView(
          lessonId: widget.lessonId,
        ));
  }
}

class _LessonView extends StatelessWidget {
  final String lessonId;
  const _LessonView({
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context) {
    final lessonBloc = context.read<LessonBloc>()
      ..add(ChangeLessonById(lessonId: lessonId));
    return BlocListener<VideoPlayerBloc, VideoPlayerState>(
        listener: (context, state) {
      if (state.videoStatus == PlayerStatus.completed) {
        lessonBloc.changeToNextLesson();
      }
    }, child: BlocBuilder<LessonBloc, LessonState>(
      builder: (context, state) {
        if (state is LessonLoaded) {
          if (lessonBloc.state.lesson.videoUrl!.length > 2) {
            context.read<VideoPlayerBloc>().add(
                VideoInitialized(video: lessonBloc.state.lesson.videoUrl!));
          }
          return Scaffold(
            body: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      color: Colors.grey[200],
                      child:
                          const SizedBox(height: 680, child: VideoPlayerView()),
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
                LessonInfo(
                  lessonBloc: lessonBloc,
                  state: state,
                  lessonId: lessonId,
                ),
              ],
            ),
          );
        }

        if (state is LessonLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LessonError) {
          return const Center(child: Text("Error"));
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    ));
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
