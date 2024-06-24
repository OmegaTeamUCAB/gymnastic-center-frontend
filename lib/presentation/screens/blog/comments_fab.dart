import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/blog/custom_modal_sheet.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_comments.dart';

class CommentsFAB extends StatelessWidget {
  final String blogId;
  const CommentsFAB({super.key, required this.blogId});

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
              child: BlogComments(blogId: blogId),
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
