import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
import 'package:gymnastic_center/presentation/utils/format_date_time.dart';
import 'package:gymnastic_center/presentation/widgets/profile/profile_avatar.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileAvatar(
          fullName: comment.user,
          radius: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${comment.user} | ${formatDateTime(comment.date)}',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                comment.body,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.thumb_up_off_alt_outlined,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(comment.countLikes.toString()),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.thumb_down_off_alt_outlined,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(comment.countDislikes.toString()),
                ],
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.delete_outline_rounded,
            size: 20,
          ),
        )
      ],
    );
  }
}
