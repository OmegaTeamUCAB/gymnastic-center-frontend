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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add your code here
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Comments',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 30,
                      ))
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.outline,
              height: 0,
              thickness: 1,
            ),
            BlogComments(
              blogId: blogId,
              comments: [
                Comment(
                  imageUrl: 'https://art.pixilart.com/c7e394b256b37bc.png',
                  comment: 'This is a great blog post!',
                  author: 'User1',
                  date: DateTime.now(),
                ),
                Comment(
                  imageUrl: 'https://art.pixilart.com/c7e394b256b37bc.png',
                  comment: 'I found this post very helpful.',
                  author: 'User2',
                  date: DateTime.now(),
                ),
                Comment(
                  imageUrl: 'https://art.pixilart.com/c7e394b256b37bc.png',
                  comment: 'Thanks for sharing this post.',
                  author: 'User3',
                  date: DateTime.now(),
                ),
              ],
            ),
          ],
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
