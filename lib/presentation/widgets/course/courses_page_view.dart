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
      children: List.generate(
        (courses.length / 2).ceil(), // Calculate the number of columns
        (index) {
          // Calculate the indices of the courses for this column
          int firstCourseIndex = index * 2;
          int secondCourseIndex = index * 2 + 1;

          return Column(
            children: [
              CourseTile(course: courses[firstCourseIndex]),
              // Check if there is a second course for this column
              if (secondCourseIndex < courses.length)
                CourseTile(course: courses[secondCourseIndex]),
            ],
          );
        },
      ),
    );
  }
}
