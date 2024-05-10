import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/blocs/player/player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/course/finished_lesson.dart';
import 'package:gymnastic_center/presentation/widgets/player/pause_video_options.dart';
import 'package:gymnastic_center/presentation/widgets/player/progress_control_options.dart';

class VideoPlayer extends StatefulWidget {
  final PlayerBloc playerBloc;
  final PlayerState playerState;
  final CachedVideoPlayerController controller;
  const VideoPlayer({
    super.key,
    required this.controller,
    required this.playerBloc,
    required this.playerState,
  });

  @override
  State<VideoPlayer> createState() => VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayer> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) {
        final position = widget.controller.value.position;
        final int minutes = position.inMinutes.remainder(60);
        final int seconds = position.inSeconds.remainder(60);
        if (position == widget.playerBloc.state.videoDuration) {
          widget.playerBloc.add(FinishedVideo());
        }
        if (!widget.playerBloc.state.isFinished) {
          widget.playerBloc
              .add(UpdateCurrentPosition(minutes: minutes, seconds: seconds));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.playerBloc.add(TogglePlaying());
      },
      child: Scaffold(
        body: Stack(
          children: [
            CachedVideoPlayer(widget.controller),
            if (widget.playerState.isPlaying == false ||
                widget.playerState.isFinished)
              PauseControlOptions(
                  playerBloc: widget.playerBloc,
                  playerState: widget.playerState),
            if (widget.playerState.isFinished)
              const Stack(
                children: [
                  FinishedLesson(),
                ],
              ),
            PauseVideoOptions(
              playerBloc: widget.playerBloc,
              playerState: widget.playerState,
            ),
          ],
        ),
      ),
    );
  }
}
