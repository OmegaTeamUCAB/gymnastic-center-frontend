import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/delete_comment/delete_comment_bloc.dart';
import 'package:gymnastic_center/application/blocs/like_or_dislike_comment/like_or_dislike_comment_bloc.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
import 'package:gymnastic_center/presentation/utils/format_date_time.dart';
import 'package:gymnastic_center/presentation/widgets/comment/delete_button.dart';
import 'package:gymnastic_center/presentation/widgets/profile/profile_avatar.dart';

class CommentTile extends StatefulWidget {
  final Comment comment;
  final String blogId;
  const CommentTile({super.key, required this.comment, required this.blogId});

  @override
  CommentTileState createState() => CommentTileState();
}

class CommentTileState extends State<CommentTile> {
  late LikeOrDislikeCommentBloc likeOrDislikeCommentBloc;
  late int countLikes;
  late int countDislikes;
  late bool hasLiked;
  late bool hasDisliked;
  late AuthBloc authBloc;
  late DeleteCommentBloc deleteCommentBloc;

  @override
  void initState() {
    super.initState();
    authBloc = GetIt.instance<AuthBloc>();
    deleteCommentBloc = GetIt.instance<DeleteCommentBloc>();
    likeOrDislikeCommentBloc = GetIt.instance<LikeOrDislikeCommentBloc>();
    hasLiked = widget.comment.userLiked;
    hasDisliked = widget.comment.userDisliked;
    countLikes = widget.comment.countLikes;
    countDislikes = widget.comment.countDislikes;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: likeOrDislikeCommentBloc,
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
                BlocListener<LikeOrDislikeCommentBloc,
                    LikeOrDislikeCommentState>(
                  listener: (context, state) {
                    if (state is LikeOrDislikeCommentFailed) {
                    } else if (state is LikeOrDislikeCommentSuccess) {}
                  },
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Icon(
                          hasLiked
                              ? Icons.thumb_up_alt_rounded
                              : Icons.thumb_up_off_alt_outlined,
                          size: 20,
                        ),
                        onTap: () {
                          setState(() {
                            if (hasLiked) {
                              countLikes--;
                            } else {
                              countLikes++;
                              if (hasDisliked) {
                                hasDisliked = false;
                                countDislikes--;
                              }
                            }
                            hasLiked = !hasLiked;
                          });
                          likeOrDislikeCommentBloc.add(
                            LikeOrDislikeCommentRequested(
                              commentId: widget.comment.id,
                              like: true,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      _CountDisplay(count: countLikes),
                      const SizedBox(width: 20),
                      GestureDetector(
                        child: Icon(
                          hasDisliked
                              ? Icons.thumb_down_alt_rounded
                              : Icons.thumb_down_off_alt_outlined,
                          size: 20,
                        ),
                        onTap: () {
                          setState(() {
                            if (hasDisliked) {
                              countDislikes--;
                            } else {
                              countDislikes++;
                              if (hasLiked) {
                                hasLiked = false;
                                countLikes--;
                              }
                            }
                            hasDisliked = !hasDisliked;
                          });
                          likeOrDislikeCommentBloc.add(
                            LikeOrDislikeCommentRequested(
                              commentId: widget.comment.id,
                              like: false,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      _CountDisplay(count: countDislikes),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (widget.comment.userId ==
              (authBloc.state as Authenticated).user.id)
            DeleteButton(
              blogId: widget.blogId,
              modalTitle: 'Comment',
              buttonLabel: 'Delete comment', 
              commentId: widget.comment.id
            )
        ],
      ),
    );
  }
}


class _CountDisplay extends StatelessWidget {
  final int count;

  const _CountDisplay({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    String formattedCount;
    if (count >= 1000 && count < 1000000) {
      formattedCount = "${(count / 1000).toStringAsFixed(1)}K";
    } else if (count >= 1000000 && count < 1000000000) {
      formattedCount = "${(count / 1000000).toStringAsFixed(1)}M";
    } else if (count >= 1000000000) {
      formattedCount = "${(count / 1000000000).toStringAsFixed(1)}B";
    } else {
      formattedCount = count.toString();
    }

    return Text(formattedCount);
  }
}
