import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/application/blocs/course_detail/course_detail_bloc.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/use_cases/course/get_course_by_id.use_case.dart';
import 'package:gymnastic_center/presentation/screens/course/course_content_screen.dart';
import 'package:gymnastic_center/presentation/screens/course/lesson_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_info.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CourseDetailBloc(
                getCourseByIdUseCase:
                    GetIt.instance.get<GetCourseByIdUseCase>())
              ..add(CourseRequested(id: courseId))),
      ],
      child: _CourseView(
        courseId: courseId,
      ),
    );
  }
}

class _CourseView extends StatefulWidget {
  final String courseId;

  const _CourseView({super.key, required this.courseId});

  @override
  State<_CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<_CourseView> {
  final ScrollController _scrollController = ScrollController();
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 500) {
      setState(() {
        _showFab = true;
      });
    } else {
      setState(() {
        _showFab = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessonBloc = GetIt.instance<LessonBloc>();
    return BlocBuilder<CourseDetailBloc, CourseDetailState>(
      builder: (context, state) {
        if (state is CourseLoading) {
          return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            strokeWidth: 2,
          )));
        }
        if (state is CourseError) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is CourseFetched) {
          final course = state.course;
          lessonBloc.add((LoadLessons(lessons: course.lessons!)));

          return BlocProvider.value(
            value: lessonBloc,
            child: BlocBuilder<LessonBloc, LessonState>(
            builder: (context, state) {
              if(state is LessonLoading){
                return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            strokeWidth: 2,
          )));
              }

          if (state is LessonError) {
          return Center(
            child: Text(state.message),
          );
          }

              if(state is LessonLoaded){
                return Scaffold(
                body: Stack(
                  children: [
                    Image.network(
                      course.imageUrl,
                      height: 400,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return child;
                        }
                      },
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    CourseInfo(
                      course: course,
                      scrollController: _scrollController,
                    ),
                    AnimatedPositioned(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                        left: 0,
                        right: 0,
                        top: _showFab ? 0 : -140,
                        child: Container(
                          height: 110,
                          width: double.infinity,
                          color: const Color(0xFF4F14A0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                course.name,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                        top: 60,
                        left: 10,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF4F14A0),
                            shape: BoxShape.circle,
                          ),
                          child: const BackButton(
                            color: Colors.white,
                          ),
                        )),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      left: 10,
                      right: 10,
                      bottom: _showFab ? 30 : -100,
                      child: BrandButton(
                        text: 'Start Course',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LessonScreen(
                                      lessonId: course.lessons!.first.id,
                                    )),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
              } else return Center(child: Text('Error'),);
              

            },
          ));
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}
