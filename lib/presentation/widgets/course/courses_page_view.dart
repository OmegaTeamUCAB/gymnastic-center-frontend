import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/presentation/widgets/home/course_tile.dart';

class CoursesPageView extends StatelessWidget {
  final List<Course> courses;
  const CoursesPageView({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.90),
      children: List.generate(
        (courses.length / 2).ceil(),
        (index) {
          int firstCourseIndex = index * 2;
          int secondCourseIndex = index * 2 + 1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CourseTile(
                  course: courses[firstCourseIndex],
                  showBorder: secondCourseIndex < courses.length),
              if (secondCourseIndex < courses.length)
                CourseTile(course: courses[secondCourseIndex]),
            ],
          );
        },
      ),
    );
  }
}
