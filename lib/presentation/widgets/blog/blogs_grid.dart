import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/presentation/screens/blog/blog_detail_screen.dart';

class BlogsGrid extends StatelessWidget {
  final ScrollController controller;
  final List<Blog> blogs;
  const BlogsGrid({super.key, required this.blogs, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            '${blogs.length} Blogs',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: false,
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            itemCount: blogs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, i) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlogDetailScreen(
                            blogId: blogs[i].id,
                          )),
                );
              },
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        blogs[i].images.first,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(blogs[i].title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 10),
                    Text(blogs[i].trainer,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSecondary,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        )
      ],
    );
  }
}
