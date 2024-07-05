import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_modal_sheet.dart';
import 'package:gymnastic_center/presentation/widgets/comment/comments_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              blogOrLessonId: blogId,
              title: AppLocalizations.of(context)!.comments,
              child: CommentsList(blogId: blogId),
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
