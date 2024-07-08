import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/course_detail/course_detail_bloc.dart';
import 'package:gymnastic_center/application/blocs/lesson/lesson_bloc.dart';
import 'package:gymnastic_center/application/blocs/progress/progress_bloc.dart';
import 'package:gymnastic_center/application/use_cases/course/get_course_by_id.use_case.dart';
import 'package:gymnastic_center/presentation/screens/course/lesson_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        BlocProvider.value(
          value: GetIt.instance<ProgressBloc>(),
        )
      ],
      child: _CourseView(
        courseId: courseId,
      ),
    );
  }
}

class _CourseView extends StatefulWidget {
  final String courseId;

  const _CourseView({required this.courseId});

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
    GetIt.instance<ProgressBloc>().setToInitialState();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 540) {
      if (_showFab == true) return;
      setState(() {
        _showFab = true;
      });
    } else {
      if (_showFab == false) return;
      setState(() {
        _showFab = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseDetailBloc, CourseDetailState>(listener: (
      context,
      state,
    ) {
      if (state is CourseFetched) {
          GetIt.instance<ProgressBloc>().add(LessonProgressRequested(
            courseId: state.course.id,
            )
          );
          GetIt.instance<LessonBloc>().add(LoadCourseInfo(
            course: state.course.id, 
            courseImage: state.course.imageUrl, 
            lessons: state.course.lessons!
        ));
      }
    }, child: BlocBuilder<CourseDetailBloc, CourseDetailState>(
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
        final progress = GetIt.instance<ProgressBloc>();

        return BlocProvider.value(
          value: GetIt.instance<LessonBloc>(),
          child: BlocBuilder<ProgressBloc, ProgressState>(
            builder: (context, state) {
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
                    Text(
                      '${GetIt.instance<LessonBloc>().state.progress.percent}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    CourseInfo(
                      course: course,
                      scrollController: _scrollController,
                    ),
                    AnimatedPositioned(
                        duration: const Duration(milliseconds: 900),
                        curve: (_showFab) ? Curves.easeOut : Curves.easeIn,
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
                    (progress.state.progressStatus != ProgressStatus.unitialized) ? Container() : AnimatedPositioned(
                      duration: const Duration(milliseconds: 900),
                      curve: (_showFab) ? Curves.easeOut : Curves.easeIn,
                      left: 10,
                      right: 10,
                      bottom: _showFab ? 30 : -100,
                      child: BrandButton(
                        text: AppLocalizations.of(context)!.startCourse,
                        onPressed: () async {
                          await progress.startCourse(StartCourse(courseId: course.id), course.lessons!.first.id);
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
            },
          ),
        );
      } else {
        return const Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
        ));
      }
    }));
  }
}
