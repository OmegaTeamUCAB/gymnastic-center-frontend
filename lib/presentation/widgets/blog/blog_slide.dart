import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/presentation/screens/blog/blog_detail_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/new_chip.dart';
import 'package:timeago/timeago.dart';

class BlogSlide extends StatelessWidget {
  final Blog blog;
  const BlogSlide({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.surfaceTint,
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetailScreen(blogId: blog.id),
          ),
        );
      },
      child: Ink(
          height: 260,
          width: 260,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(10)),
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                blog.images.first,
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          blog.trainer!,
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        const Spacer(),
                        Text(
                          blog.category!,
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            if (DateTime.now()
                    .difference(DateTime.parse(blog.uploadDate!))
                    .inDays <
                5)
              const Positioned(top: 5, left: 5, child: NewChip()),
          ])),
    );
  }
}
