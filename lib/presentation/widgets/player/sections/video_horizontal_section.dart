import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/player/buttons/custom_speed_options.dart';

class VideoHorizontalSection extends StatelessWidget {
  const VideoHorizontalSection({
    super.key,
    required this.videoBloc,
  });

  final VideoPlayerBloc videoBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                      Shadow(color: Colors.black54, blurRadius: 10)
                    ],
                    color: Colors.white,
                    size: 28),
                onPressed: context.read<VideoPlayerBloc>().toggleMute,
              ),
              const SizedBox(width: 10),
              PopupMenuButton<double>(
                  initialValue: videoBloc.state.currentSpeed,
                  tooltip: 'Playback speed',
                  onSelected: context.read<VideoPlayerBloc>().setVideoSpeed,
                  itemBuilder: (context) => VideoPlayerBloc.speeds
                      .map<PopupMenuEntry<double>>((speed) => PopupMenuItem(
                          value: speed,
                          child: CustomSpeedOptions(
                            speed: speed,
                          )))
                      .toList(),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 10)],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}