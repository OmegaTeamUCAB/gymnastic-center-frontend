import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';
import 'package:gymnastic_center/presentation/widgets/categories/improved_blog_slide.dart';

class ImprovedBlogCarousel extends StatelessWidget {
  final IBlogRepository blogRepository;
  const ImprovedBlogCarousel({super.key, required this.blogRepository});

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
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 15),
                ...blogs.map((blog) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: ImprovedBlogSlide(blog: blog),
                  );
                }),
                const SizedBox(width: 15),
              ],
            ),
          );
        }
      },
    );
  }
}
