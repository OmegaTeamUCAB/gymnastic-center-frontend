import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/player/custom_pause_view.dart';
import 'package:gymnastic_center/presentation/widgets/player/custom_speed_options.dart';

class VideoPlayerView extends StatelessWidget {
  const VideoPlayerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final videoBloc = context.watch<VideoPlayerBloc>();
    return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
      buildWhen: (previous, current) {
        return previous.videoStatus != current.videoStatus;
      },
      builder: (context, state) {
        if (state.videoStatus == PlayerStatus.loading) {
          return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            strokeWidth: 4,
          )));
        }
        if (state.videoStatus == PlayerStatus.error) {
          return Center(child: Text('${state.message}'));
        }

        // if(state.videoStatus == PlayerStatus.completed){}

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
