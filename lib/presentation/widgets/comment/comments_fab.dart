import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_modal_sheet.dart';
import 'package:gymnastic_center/presentation/widgets/comment/comments_list.dart';

class CommentsFAB extends StatelessWidget {
  final String? blogId;
  final String? lessonId;
  const CommentsFAB({super.key, this.blogId, this.lessonId});

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
            return CustomModalSheet(
              blogId: blogId,
              lessonId: lessonId,
              child: CommentsList(
                blogId: blogId,
                lessonId: lessonId,
              ),
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
