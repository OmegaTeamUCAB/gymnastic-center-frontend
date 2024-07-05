import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/comment/comments_fab.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/player/video_player_preview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gymnastic_center/presentation/widgets/player/video_progress_bar.dart';
import 'package:gymnastic_center/presentation/widgets/player/video_duration.dart';

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
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.grey[200],
                            child: const SizedBox(
                                width: 600,
                                height: 600,
                                child: VideoPlayerView()),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
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
                    !state.lastLesson
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
                                          Text(lessonBloc.getNextLesson().title,
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
                    child: CommentsFAB(blogId: lessonId)),
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
