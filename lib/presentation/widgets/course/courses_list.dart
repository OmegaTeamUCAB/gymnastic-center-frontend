import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/presentation/widgets/home/course_tile.dart';

class CoursesList extends StatelessWidget {
  final List<Course> courses;
  final ScrollController controller;
  const CoursesList(
      {super.key, required this.courses, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            '${courses.length} Courses',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
              shrinkWrap: false,
              physics: const AlwaysScrollableScrollPhysics(),
              controller: controller,
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return CourseTile(course: courses[index]);
              },
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        )
      ],
    );
  }
}
