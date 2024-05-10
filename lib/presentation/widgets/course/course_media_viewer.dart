import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/presentation/widgets/course/lesson_list_view.dart';

class CourseMediaViewer extends StatelessWidget {
  final Course course;
  final int currentLesson;
  final Function(int) onTap;
  const CourseMediaViewer({
    super.key,
    required this.currentLesson,
    required this.onTap,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(60), topLeft: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Course content',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_sharp, color: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Expanded(
                child: LessonListView(
                  lessons: course.lessons,
                  currentIndexLesson: currentLesson,
                  onTap: (index) {
                    onTap(index);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
