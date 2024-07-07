import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/like_or_dislike_comment/like_or_dislike_comment_bloc.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
import 'package:gymnastic_center/presentation/widgets/comment/like_and_dislike_count.dart';

class LikeAndDislikeButtons extends StatefulWidget {
  final Comment comment;
  final LikeOrDislikeCommentBloc likeOrDislikeCommentBloc;
  const LikeAndDislikeButtons(
      {super.key,
      required this.comment,
      required this.likeOrDislikeCommentBloc});

  @override
  State<LikeAndDislikeButtons> createState() => _LikeAndDislikeButtonsState();
}

class _LikeAndDislikeButtonsState extends State<LikeAndDislikeButtons> {
  late LikeOrDislikeCommentBloc likeOrDislikeCommentBloc;
  late int countLikes;
  late int countDislikes;
  late bool hasLiked;
  late bool hasDisliked;

  @override
  void initState() {
    super.initState();
    likeOrDislikeCommentBloc = widget.likeOrDislikeCommentBloc;
    hasLiked = widget.comment.userLiked!;
    hasDisliked = widget.comment.userDisliked!;
    countLikes = widget.comment.countLikes!;
    countDislikes = widget.comment.countDislikes!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LikeOrDislikeCommentBloc, LikeOrDislikeCommentState>(
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
          LikeAndDislikeCount(count: countLikes),
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
          LikeAndDislikeCount(count: countDislikes),
        ],
      ),
    );
  }
}
