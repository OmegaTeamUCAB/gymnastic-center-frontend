import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_slide.dart';

class BlogCarousel extends StatelessWidget {
  final List<Blog> blogs;
  const BlogCarousel({super.key, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          if (index % 2 == 0) {
            // Render a SizedBox for every even index
            return const SizedBox(width: 15);
          } else {
            return BlogSlide(blog: blogs[index ~/ 2]);
          }
        },
      ),
    );
  }
}
