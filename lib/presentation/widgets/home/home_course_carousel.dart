import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gymnastic_center/presentation/data/dummy_courses.dart';
import 'package:gymnastic_center/presentation/widgets/home/course_tile.dart';

class HomeCourseCarousel extends StatelessWidget {
  const HomeCourseCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: PageView(
        scrollDirection: Axis.horizontal,
        // todo: connect data to the carousel
        children: const [
          // Column(
          //   children: [
          //     CourseTile(course: dummyCourses[0]),
          //     CourseTile(course: dummyCourses[1]),
          //   ],
          // ),
          // Column(
          //   children: [
          //     CourseTile(course: dummyCourses[2]),
          //     CourseTile(course: dummyCourses[3]),
          //   ],
          // ),
          // Column(
          //   children: [
          //     CourseTile(course: dummyCourses[4]),
          //     CourseTile(course: dummyCourses[0]),
          //   ],
          // ),
        ],
      ),
    );
  }
}
