import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_media_viewer.dart';
import 'package:gymnastic_center/presentation/widgets/course/lesson_card.dart';

class CourseContentScreen extends StatefulWidget {
  final Course course;
  const CourseContentScreen({super.key, required this.course});

  @override
  State<CourseContentScreen> createState() => _CourseContentScreenState();
}

class _CourseContentScreenState extends State<CourseContentScreen> {
  int currentLesson = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Container(
              height: size.height * 0.46,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: CourseViewer(
                  lesson: widget.course.lessons[currentLesson],
                ),
              )),
          CourseMediaViewer(
            currentLesson: currentLesson,
            course: widget.course,
            onTap: (index) {
              setState(() {
                currentLesson = index;
              });
            },
          )
        ],
      ),
    );
  }
}
