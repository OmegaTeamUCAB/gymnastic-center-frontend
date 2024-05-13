import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_detail.dart';

class BlogList extends StatelessWidget {
  final IBlogRepository blogRepository;

  const BlogList({super.key, required this.blogRepository});

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
          return Container();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<Blog> blogs = snapshot.data!;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Our Latest Blogs',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 209 + 84 - 14,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: blogs.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 250,
                      height: 209,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlogDetail(
                                              blogId: blogs[index].id),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              blogs[index].imageUrl,
                                              fit: BoxFit.cover,
                                              width: 230,
                                              height: 180,
                                            ),
                                            Positioned(
                                              right: 10,
                                              top: 10,
                                              child: Container(
                                                width: 45,
                                                height: 18,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF7351E6),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'New', //todo: should optionally rendered
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(blogs[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Text('No hay blogs');
        }
      },
    );
  }
}
