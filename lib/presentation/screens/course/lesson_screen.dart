import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/video_player/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/player/video_player_preview.dart';
import 'package:gymnastic_center/presentation/widgets/player/video_progress_bar.dart';
import 'package:gymnastic_center/presentation/widgets/player/video_duration.dart';

class LessonScreen extends StatefulWidget {
  final String lessonId;

  LessonScreen({
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
          BlocProvider.value(value: videoPlayerBloc,)
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final lessonBloc = context.read<LessonBloc>()..add(ChangeLessonById(lessonId: lessonId));
    return BlocListener<VideoPlayerBloc, VideoPlayerState>(
      listener: (context, state) {

          if(state.videoStatus == PlayerStatus.completed){
            lessonBloc.changeToNextLesson();
          }
      }
      ,
      child: BlocBuilder<LessonBloc, LessonState>(
      builder: (context, state) {
        if (state is LessonLoaded) {
          if(lessonBloc.state.lesson.videoUrl!.length > 2)
          context.read<VideoPlayerBloc>()
            ..add(VideoInitialized(video: lessonBloc.state.lesson.videoUrl!));
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.grey[200],
                            child: Container(
                              width: 600,
                              height: 600,
                              child: VideoPlayerView()
                            ),
                          ),
                          Positioned(
                            top: 40,
                            right: 20,
                            child: IconButton(
                              icon: Icon(Icons.close_rounded,
                                  color: Colors.white, size: 30),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: VideoProgressBar(),
                    ),
          //           Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // Handle next exercise action
          //     },
          //     child: Text('NEXT EXERCISE'),
          //     style: ButtonStyle(
          //       minimumSize: MaterialStateProperty.all(Size(double.infinity, 48)),
          //       backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
          //       foregroundColor: MaterialStateProperty.all(Colors.black),
          //     ),
          //   ),
          // ),
          _VideoTitle(title: lessonBloc.state.lesson.title),
                    VideoDuration()
  ,                 Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: lessonBloc.changeToPreviousLesson,
                            child: Text('PREV'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: lessonBloc.changeToNextLesson,
                            child: Text('NEXT'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    !state.lastLesson
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://elestimulo.com/wp-content/uploads/2023/06/Foto-pa-ruti-pecho-pa%CC%81gina--1100x572.jpg',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${lessonBloc.getNextLesson().title}',
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          Text('0:30',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey)),
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
              ],
            ),
          );
        }

        if (state is LessonLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is LessonError) {
          return Center(child: Text("Error"));
        } else
          return Center(
            child: Text('Error'),
          );
      },
    ));
  }
}

class _VideoTitle extends StatelessWidget {
  final String title;
  
  const _VideoTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 3,
      textAlign: TextAlign.center,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
