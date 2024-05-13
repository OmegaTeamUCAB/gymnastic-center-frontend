import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/presentation/widgets/blog/Blog_Detail.dart';

class ImprovedBlogSlide extends StatelessWidget {
  final Blog blog;
  const ImprovedBlogSlide({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.surfaceTint,
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetail(blogId: blog.id),
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
                blog.imageUrl,
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
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Dieta',
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        const Spacer(),
                        Text(
                          '15/05/2024',
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ])),
    );
  }
}
