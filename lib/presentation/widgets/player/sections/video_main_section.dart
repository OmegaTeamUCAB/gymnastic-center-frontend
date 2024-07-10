import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/player/buttons/custom_pause_view.dart';
import 'package:gymnastic_center/presentation/widgets/player/overlays/course_ended_overlay.dart';
import 'package:gymnastic_center/presentation/widgets/player/sections/video_horizontal_section.dart';

class VideoMainSection extends StatelessWidget {
  const VideoMainSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
      buildWhen: (previous, current) =>
          previous.videoStatus != current.videoStatus,
      builder: (context, state) {
        if (state.videoStatus == PlayerStatus.completed) {
          return CourseEndedOverlay();
        }
        if (state.videoStatus == PlayerStatus.streaming) {
          final videoBloc = context.watch<VideoPlayerBloc>();

          return Positioned.fill(
            child: Stack(
              children: [
                if (!videoBloc.state.isPlaying)
                  FadeIn(
                    duration: Durations.medium2,
                    child: CustomPauseView(
                        onPressed: context.read<VideoPlayerBloc>().togglePlay),
                  ),
                VideoHorizontalSection(videoBloc: videoBloc)
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
