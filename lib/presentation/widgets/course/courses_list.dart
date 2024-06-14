import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/presentation/widgets/home/course_tile.dart';

class CoursesList extends StatelessWidget {
  final List<Course> courses;
  final ScrollController controller;
  const CoursesList(
      {super.key, required this.courses, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: ListView.builder(
        controller: controller,
        shrinkWrap: false,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseTile(course: courses[index]);
        },
      ),
    );
  }
}
