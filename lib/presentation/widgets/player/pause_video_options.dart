import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/blocs/player/player_bloc.dart';

class PauseVideoOptions extends StatelessWidget {
  final PlayerBloc playerBloc;
  final PlayerState playerState;
  const PauseVideoOptions({
    super.key,
    required this.playerBloc,
    required this.playerState,
  });

  static const speeds = <double>[1, 2];

  _durationString(int minutes, int seconds) {
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                          (playerState.isMuted)
                              ? Icons.volume_off
                              : Icons.volume_up,
                          color: Colors.white,
                          size: 28),
                      onPressed: () {
                        playerBloc.add(ToggleMute());
                      },
                    ),
                    const SizedBox(width: 10),
                    PopupMenuButton<double>(
                        initialValue: playerBloc
                            .cachedVideoPlayerController.value.playbackSpeed,
                        tooltip: 'Playback speed',
                        onSelected: playerBloc
                            .cachedVideoPlayerController.setPlaybackSpeed,
                        itemBuilder: (context) => speeds
                            .map<PopupMenuEntry<double>>(
                                (speed) => PopupMenuItem(
                                    value: speed,
                                    child: _SpeedOptions(
                                      speed: speed,
                                    )))
                            .toList(),
                        child: const Icon(Icons.settings,
                            color: Colors.white, size: 30)),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.playlist_add,
                          color: Colors.white, size: 28),
                      onPressed: () {
                        const snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text('No hay lista por los momentos'),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 13,
                  child: VideoProgressIndicator(
                    playerBloc.cachedVideoPlayerController,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: Colors.deepPurple,
                      bufferedColor: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _durationString(playerState.minutes, playerState.seconds),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}

class _SpeedOptions extends StatelessWidget {
  final double speed;
  const _SpeedOptions({required this.speed});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Text(
      '$speed',
      style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
    )));
  }
}
