import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/blog_detail/blog_detail_bloc.dart';
import 'package:gymnastic_center/presentation/utils/format_date_time.dart';
import 'package:gymnastic_center/presentation/widgets/blog/add_comment_bar.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_comments.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class BlogDetailScreen extends StatelessWidget {
  final String blogId;

  const BlogDetailScreen({super.key, required this.blogId});

  @override
  Widget build(BuildContext context) {
    final blogDetailBloc = GetIt.instance<BlogDetailBloc>();
    blogDetailBloc.add(BlogDetailRequested(blogId: blogId));
    return Scaffold(
      body: BlocProvider<BlogDetailBloc>.value(
        value: blogDetailBloc,
        child: BlocBuilder<BlogDetailBloc, BlogDetailState>(
          builder: (context, state) {
            if (state is BlogDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BlogDetailLoaded) {
              return LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: [
                              Transform.translate(
                                offset: const Offset(0, 20),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(40.0),
                                          ),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                state.blog.images.first,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 400,
                                                fit: BoxFit.cover,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 400,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 300,
                                            child: Text(
                                              state.blog.title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(1.0, 1.0),
                                                    blurRadius: 3.0,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            formatDateTime(DateTime.parse(
                                                state.blog.uploadDate!)),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(1.0, 1.0),
                                                  blurRadius: 3.0,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const PreferredSize(
                                preferredSize: Size(double.infinity, 100),
                                child: CustomAppBar(
                                  content: Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        BrandBackButton(
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Blog',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  state.blog.content!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite_border)),
                              const Text('5'),
                              const SizedBox(
                                width: 16,
                              ),
                              IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25.0)),
                                      ),
                                      builder: (BuildContext context) {
                                        return Column(
                                          children: [
                                            const Text(
                                              'Comments',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Flexible(
                                              child: SingleChildScrollView(
                                                child: BlogComments(
                                                    blogId: blogId),
                                              ),
                                            ),
                                            AddCommentBar(
                                              blogId: blogId,
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.comment_outlined)),
                              const Text('16'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Error loading blog'),
              );
            }
          },
        ),
      ),
    );
  }
}
