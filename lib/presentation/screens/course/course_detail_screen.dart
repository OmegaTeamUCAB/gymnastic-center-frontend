import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/presentation/screens/course/course_content_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_carrusel.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_detail_info_card.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    Future.delayed(Duration.zero, () {
      context.read<CourseBloc>().add(GetCourseById(courseId: widget.courseId));
    });
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
    final courseIsLoading = context.watch<CourseBloc>().state.isLoading;
    final course = context.watch<CourseBloc>().state.course;
    final popularCourses = context.watch<CourseBloc>().state.popularCourses;

    if (courseIsLoading) {
      return const Scaffold(
          body: Center(
              child: CircularProgressIndicator(
        strokeWidth: 2,
      )));
    }
    if (course == null) {
      return const Center(
        child: Text('No existe el curso'),
      );
    }

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
          SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              margin: const EdgeInsets.only(top: 365),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            course.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            'John Doe',
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CourseDetailInfoCard(
                          label: 'Level ${course.level.toString()}',
                          iconData: Icons.menu,
                        ),
                        CourseDetailInfoCard(
                          label: '${course.weeks.toString()} Weeks',
                          iconData: Icons.calendar_month_sharp,
                        ),
                        CourseDetailInfoCard(
                          label: '${course.minutes.toString()} mins',
                          iconData: Icons.watch_later_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    BrandButton(
                      child: Text(
                        'Start course',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CourseContentScreen(course: course)),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      course.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Divider(
                      height: 30,
                    ),
                    Text('15 Lessons',
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onPrimary)),
                    const SizedBox(
                      height: 12,
                    ),
                    const Placeholder(
                      fallbackHeight: 800,
                      fallbackWidth: double.infinity,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text('More Most Popular Courses',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 20)),
                    const SizedBox(
                      height: 12,
                    ),
                    CourseCarrusel(
                      width: double.infinity,
                      courses: popularCourses,
                      onTap: (courseId) {
                        context
                            .read<CourseBloc>()
                            .add(GetCourseById(courseId: courseId));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              left: 0,
              right: 0,
              top: _showFab ? 0 : -140,
              child: Container(
                height: 95,
                width: double.infinity,
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      course.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )),
          Positioned(
            top: 45,
            left: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Material(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                    child: BackButton(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            left: 10,
            right: 10,
            bottom: _showFab ? 30 : -100,
            child: BrandButton(
              child: Text(
                'Start course',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CourseContentScreen(course: course)),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
