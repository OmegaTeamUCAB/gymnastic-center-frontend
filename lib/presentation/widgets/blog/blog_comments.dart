import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gymnastic_center/presentation/utils/format_date_time.dart';
import 'package:gymnastic_center/presentation/widgets/profile/profile_avatar.dart';

class Comment {
  final String imageUrl;
  final String comment;
  final String author;
  final DateTime date;
  int likes;
  int dislikes;

  Comment({
    required this.imageUrl,
    required this.comment,
    required this.author,
    required this.date,
    this.likes = 0,
    this.dislikes = 0,
  });
}

class BlogComments extends StatelessWidget {
  final String blogId;
  final List<Comment> comments;

  const BlogComments({
    super.key,
    required this.blogId,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileAvatar(
                  fullName: comment.author,
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${comment.author} | ${formatDateTime(comment.date)}',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.more_vert_rounded,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        comment.comment,
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
                          Text(comment.likes.toString()),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.thumb_down_off_alt_outlined,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(comment.dislikes.toString()),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
