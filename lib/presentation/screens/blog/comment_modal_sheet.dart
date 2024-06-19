import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/blog/add_comment_bar.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_comments.dart';

class CommentModalSheet extends StatelessWidget {
  final String blogId;
  const CommentModalSheet({super.key, required this.blogId});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Comments',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 30,
                      ))
                ],
              ),
              Expanded(child: BlogComments(blogId: blogId)),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AddCommentBar(
            blogId: blogId,
          ),
        ),
      ],
    );
  }
}
