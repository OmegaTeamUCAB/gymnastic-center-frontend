import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/presentation/screens/blog/blog_detail_screen.dart';
import 'package:gymnastic_center/presentation/utils/format_date_time.dart';

class BlogsGrid extends StatelessWidget {
  final ScrollController? controller;
  final List<Blog> blogs;
  const BlogsGrid({super.key, required this.blogs, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: false,
      controller: controller,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: blogs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5 / 6,
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              Row(
                children: [
                  Text(blogs[i].category!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSecondary,
                      )),
                  const Spacer(),
                  Text(formatDateTime(DateTime.parse(blogs[i].uploadDate!)),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSecondary,
                      )),
                  const SizedBox(
                    width: 5,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
