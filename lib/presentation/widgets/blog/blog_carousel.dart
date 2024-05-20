import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_slide.dart';

class BlogCarousel extends StatelessWidget {
  final IBlogRepository blogRepository;
  const BlogCarousel({super.key, required this.blogRepository});

  //! this should only receive a list of blogs
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Blog>>(
      future: blogRepository.getAllBlogs().then((result) {
        if (result.isSuccessful) {
          return result.unwrap();
        } else {
          throw Exception('Failed to load blogs');
        }
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Blog> blogs = snapshot.data!;
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
                  return ImprovedBlogSlide(blog: blogs[index ~/ 2]);
                }
              },
            ),
          );
        }
      },
    );
  }
}
