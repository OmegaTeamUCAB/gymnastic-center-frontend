import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:gymnastic_center/application/models/comment.dart';

class CommentsList extends StatelessWidget {
  final List<Comment> comments;

  const CommentsList({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: comments.map((Comment comment) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.example.com/path/to/your/generic/image.jpg'),
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Usuario',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary)),
                const SizedBox(
                  width: 10,
                ),
                Text(timeago.format(comment.postedAt),
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onPrimary))
              ],
            ),
            subtitle: Text(comment.content),
          );
        }).toList(),
      ),
    );
  }
}
