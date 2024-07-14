import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/player/sections/video_main_section.dart';

class VideoPlayerView extends StatefulWidget {
  final String videoId;
  final Duration? time;
  final Duration? totalDuration;

  VideoPlayerView(
      {super.key, required this.videoId, this.time = Duration.zero, this.totalDuration});

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.instance<VideoPlayerBloc>(),
      child: _PlayerView(
        videoId: widget.videoId,
        time: widget.time!,
        totalDuration: widget.totalDuration,
      ),
    );
  }
}

class _PlayerView extends StatefulWidget {
  final String videoId;
  final Duration time;
  final Duration? totalDuration;
  const _PlayerView(
      {super.key, required this.videoId, required this.time, this.totalDuration});

  @override
  State<_PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<_PlayerView> {
  @override
  void initState() {
    super.initState();
        // ignore: unused_local_variable
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoBloc = GetIt.instance<VideoPlayerBloc>()..add(VideoInitialized(
          video: widget.videoId,
          time: widget.time,
      ));
    return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
      buildWhen: (previous, current) => previous.videoStatus != current.videoStatus,
      builder: (context, state) {
        if (state.videoStatus == PlayerStatus.loading) {
          return const Scaffold(
              backgroundColor: Colors.black12,
              body: Center(
                  child: CircularProgressIndicator(
            strokeWidth: 4,
          )));
        }
        if (state.videoStatus == PlayerStatus.error) {
          return Center(child: Text('${state.message}'));
        }

        if (state.videoStatus == PlayerStatus.streaming || state.videoStatus == PlayerStatus.completed) {
          return GestureDetector(
            onTap: context.read<VideoPlayerBloc>().togglePlay,
            child: Stack(
              children: [
                SizedBox.expand(
                  child: AspectRatio(
                    aspectRatio:
                        videoBloc.videoPlayerController.value.aspectRatio,
                    child: CachedVideoPlayer(videoBloc.videoPlayerController),
                  ),
                ),
                const VideoMainSection(),
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
                          )
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
