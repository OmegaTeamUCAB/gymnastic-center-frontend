import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
import 'package:gymnastic_center/presentation/widgets/comment/comment_tile.dart';

class BlogComments extends StatelessWidget {
  final List<Comment> comments;

  const BlogComments({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Padding(
            padding: const EdgeInsets.all(15),
            child: CommentTile(
              comment: comment,
            ));
      },
    );
  }
}
