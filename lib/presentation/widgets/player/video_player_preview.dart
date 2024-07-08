import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/player/custom_pause_view.dart';
import 'package:gymnastic_center/presentation/widgets/player/custom_speed_options.dart';

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoBloc = GetIt.instance<VideoPlayerBloc>()
      ..add(VideoInitialized(
          video: widget.videoId,
          time: widget.time,
      ));
    return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
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

        if(state.videoStatus == PlayerStatus.completed){
          return SizedBox.expand(
            child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          SizedBox.expand(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Course completed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(onPressed: () {
                    
                  }, 
                  child: Text(
                    'Go back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ) 
                ),
                ],
              ),
            ),
          )
          ]));
        }

        if (state.videoStatus == PlayerStatus.streaming) {
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
                if (!videoBloc.state.isPlaying)
                  CustomPauseView(
                      onPressed: context.read<VideoPlayerBloc>().togglePlay),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                    (videoBloc.state.isMuted)
                                        ? Icons.volume_off
                                        : Icons.volume_up,
                                    shadows: const [
                                      Shadow(
                                          color: Colors.black54, blurRadius: 10)
                                    ],
                                    color: Colors.white,
                                    size: 28),
                                onPressed:
                                    context.read<VideoPlayerBloc>().toggleMute,
                              ),
                              const SizedBox(width: 10),
                              PopupMenuButton<double>(
                                  initialValue: videoBloc.state.currentSpeed,
                                  tooltip: 'Playback speed',
                                  onSelected: context
                                      .read<VideoPlayerBloc>()
                                      .setVideoSpeed,
                                  itemBuilder: (context) => VideoPlayerBloc
                                      .speeds
                                      .map<PopupMenuEntry<double>>(
                                          (speed) => PopupMenuItem(
                                              value: speed,
                                              child: CustomSpeedOptions(
                                                speed: speed,
                                              )))
                                      .toList(),
                                  child: const Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 30,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black54, blurRadius: 10)
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 60,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded,
                        shadows: [
                          Shadow(color: Colors.black54, blurRadius: 10)
                        ],
                        color: Colors.white,
                        size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
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
