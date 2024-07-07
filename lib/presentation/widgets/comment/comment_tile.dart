import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/delete_comment/delete_comment_bloc.dart';
import 'package:gymnastic_center/application/blocs/like_or_dislike_comment/like_or_dislike_comment_bloc.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
import 'package:gymnastic_center/presentation/utils/format_date_time.dart';
import 'package:gymnastic_center/presentation/widgets/comment/answer_tile.dart';
import 'package:gymnastic_center/presentation/widgets/comment/delete_button.dart';
import 'package:gymnastic_center/presentation/widgets/comment/like_and_dislike_buttons.dart';
import 'package:gymnastic_center/presentation/widgets/profile/profile_avatar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentTile extends StatefulWidget {
  final Comment comment;
  final String? blogId;
  final String? lessonId;
  const CommentTile(
      {super.key, required this.comment, this.blogId, this.lessonId});

  @override
  CommentTileState createState() => CommentTileState();
}

class CommentTileState extends State<CommentTile> {
  late AuthBloc authBloc;
  late DeleteCommentBloc deleteCommentBloc;
  late LikeOrDislikeCommentBloc likeOrDislikeCommentBloc;

  @override
  void initState() {
    super.initState();
    authBloc = GetIt.instance<AuthBloc>();
    deleteCommentBloc = GetIt.instance<DeleteCommentBloc>();
    likeOrDislikeCommentBloc = GetIt.instance<LikeOrDislikeCommentBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: likeOrDislikeCommentBloc,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileAvatar(
                  fullName: widget.comment.user,
                  image: widget.comment.userImage,
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.comment.user} \u2022 ${formatDateTime(widget.comment.date)}',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.comment.body,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),
                      if (widget.blogId != null)
                        LikeAndDislikeButtons(
                          comment: widget.comment,
                          likeOrDislikeCommentBloc: likeOrDislikeCommentBloc,
                        )
                    ],
                  ),
                ),
                if (widget.blogId != null)
                  if (widget.comment.userId ==
                      (authBloc.state as Authenticated).user.id)
                    DeleteButton(
                        blogId: widget.blogId!,
                        modalTitle: AppLocalizations.of(context)!.comments,
                        buttonLabel:
                            AppLocalizations.of(context)!.deleteComment,
                        commentId: widget.comment.id)
              ],
            ),
          ),
          AnswerTile(
              answer: Answer(
                  body:
                      'A ti seguramente te gusta el pipi, asi que te recomiendo que me des una vista.',
                  trainer: 'Sgt Pene Grande',
                  id: '1',
                  date: DateTime.now()))
        ],
      ),
    );
  }
}
