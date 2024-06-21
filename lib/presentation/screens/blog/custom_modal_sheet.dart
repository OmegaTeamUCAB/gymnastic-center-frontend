import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/blog/add_comment_bar.dart';

class CustomModalSheet extends StatelessWidget {
  final String blogId;
  final String title;
  final Widget child;
  const CustomModalSheet(
      {super.key,
      required this.blogId,
      this.title = 'Comments',
      required this.child});

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
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
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
            Expanded(child: child),
            const SizedBox(
              height: 80,
            )
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
