import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gymnastic_center/presentation/data/dummy_courses.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_course_card.dart';

class HomeCourseCarousel extends StatelessWidget {
  const HomeCourseCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: PageView(
        scrollDirection: Axis.horizontal,
        // todo: connect data to the carousel
        children: [
          Column(
            children: [
              HomeCourseCard(course: dummyCourses[0]),
              HomeCourseCard(course: dummyCourses[0]),
            ],
          ),
          Column(
            children: [
              HomeCourseCard(course: dummyCourses[0]),
              HomeCourseCard(course: dummyCourses[0]),
            ],
          ),
          Column(
            children: [
              HomeCourseCard(course: dummyCourses[0]),
              HomeCourseCard(course: dummyCourses[0]),
            ],
          ),
        ],
      ),
    );
  }
}
