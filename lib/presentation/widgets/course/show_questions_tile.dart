import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/comment/comments_list.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_modal_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowQuestionsTile extends StatelessWidget {
  final String lessonId;
  const ShowQuestionsTile({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(AppLocalizations.of(context)!.questions),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Theme.of(context).colorScheme.surfaceTint,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 18,
        ),
        trailing: Icon(Icons.question_answer,
            color: Theme.of(context).colorScheme.onPrimary),
        onTap: () {
          showModalBottomSheet(
            backgroundColor: Theme.of(context).colorScheme.background,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            builder: (BuildContext context) {
              return CustomModalSheet(
                lessonId: lessonId,
                child: CommentsList(
                  lessonId: lessonId,
                ),
              );
            },
          );
        });
  }
}
