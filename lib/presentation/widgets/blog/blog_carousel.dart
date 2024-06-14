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
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: BlogSlide(blog: blogs[index]),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: BlogSlide(blog: blogs[index]),
          );
        },
      ),
    );
  }
}
