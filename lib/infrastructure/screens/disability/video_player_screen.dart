import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/player/player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/player/pause_video_options.dart';
import 'package:gymnastic_center/presentation/widgets/player/progress_control_options.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerBloc>(
      create: (context) {
        final videoPlayerBloc =
            PlayerBloc(CachedVideoPlayerController.network(videoUrl));
        videoPlayerBloc.add(InitializePlayer(videoUrl: videoUrl));
        return videoPlayerBloc;
      },
      child: const FullVideoPlayer(),
    );
  }
}

class FullVideoPlayer extends StatelessWidget {
  const FullVideoPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final playerBloc = context.watch<PlayerBloc>();
    final playerState = context.watch<PlayerBloc>().state;
    final controller = context.watch<PlayerBloc>().cachedVideoPlayerController;

    return Center(
      child: (playerState.isInitialized)
          ? _VideoPlayer(
              controller: controller,
              playerBloc: playerBloc,
              playerState: playerState,
            )
          : const CircularProgressIndicator(
              strokeWidth: 2,
            ),
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  final PlayerBloc playerBloc;
  final PlayerState playerState;
  final CachedVideoPlayerController controller;
  const _VideoPlayer({
    super.key,
    required this.controller,
    required this.playerBloc,
    required this.playerState,
  });

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
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
        if (!widget.playerBloc.state.isFinished)
          widget.playerBloc
              .add(UpdateCurrentPosition(minutes: minutes, seconds: seconds));
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
              Stack(
                children: [
                  _FinishedLesson(),
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

class _FinishedLesson extends StatelessWidget {
  const _FinishedLesson({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
        Text('Lección completada',
            style: TextStyle(fontSize: 30, color: Colors.white)),
        Center(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 60,
            ),
          ),
        )
              ],
            ));
  }
}
