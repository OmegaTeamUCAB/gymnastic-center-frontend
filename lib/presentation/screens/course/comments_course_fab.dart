import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/course/custom_modal_sheet_course.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_comments.dart';

class CommentsCourseFAB extends StatefulWidget {
  final String lessonId;
  const CommentsCourseFAB({
    super.key,
    required this.lessonId,
  });

  @override
  State<CommentsCourseFAB> createState() => _CommentsCourseFABState();
}

class _CommentsCourseFABState extends State<CommentsCourseFAB> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: const Color(0xFF4F14A0),
      onPressed: () {
        
        showModalBottomSheet(
          backgroundColor: Theme.of(context).colorScheme.background,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return CustomModalSheetCourse(
            lessonId: widget.lessonId,
            child: CourseComments(lessonId: widget.lessonId),
                          );
              }, 
            );
          },
        );
      },
      child: const Icon(
        Icons.comment_outlined,
        color: Colors.white,
      ),
    );
  }
}
