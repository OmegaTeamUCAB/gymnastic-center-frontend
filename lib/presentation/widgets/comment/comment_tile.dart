import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/like_or_dislike_comment/like_or_dislike_comment_bloc.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
import 'package:gymnastic_center/presentation/utils/format_date_time.dart';
import 'package:gymnastic_center/presentation/widgets/profile/profile_avatar.dart';

class CommentTile extends StatefulWidget {
  final Comment comment;
  const CommentTile({super.key, required this.comment});

  @override
  CommentTileState createState() => CommentTileState();
}

class CommentTileState extends State<CommentTile> {
  late LikeOrDislikeCommentBloc likeOrDislikeCommentBloc;
  late int countLikes;
  late int countDislikes;
  bool hasLiked = false;
  bool hasDisliked = false;

  @override
  void initState() {
    super.initState();
    likeOrDislikeCommentBloc = GetIt.instance<LikeOrDislikeCommentBloc>();
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
                      IconButton(
                        icon: const Icon(
                          Icons.thumb_up_off_alt_outlined,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            if (hasDisliked) {
                              countDislikes -= 1;
                              hasDisliked = false;
                            }
                            if (!hasLiked) {
                              countLikes += 1;
                              hasLiked = true;
                            }
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
                      IconButton(
                        icon: const Icon(
                          Icons.thumb_down_off_alt_outlined,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            if (hasLiked) {
                              countLikes -= 1;
                              hasLiked = false;
                            }
                            if (!hasDisliked) {
                              countDislikes += 1;
                              hasDisliked = true;
                            }
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
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: Text(
                              'Comment',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // Add your delete logic here
                            },
                            icon: Icon(Icons.delete_outline_rounded,
                                size: 20,
                                color: Theme.of(context).colorScheme.onPrimary),
                            label: Text(
                              'Delete comment',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 20,
            ),
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
