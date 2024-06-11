import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/presentation/screens/course/course_content_screen.dart';
import 'package:gymnastic_center/presentation/screens/loading_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_info.dart';

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

    if (courseIsLoading) {
      return const LoadingScreen();
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
                child: const BrandBackButton(
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
