import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/blog_detail/blog_detail_bloc.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
import 'package:gymnastic_center/presentation/screens/blog/blog_info.dart';
import 'package:gymnastic_center/presentation/screens/blog/custom_modal_sheet.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_comments.dart';

class BlogDetailScreen extends StatefulWidget {
  final String blogId;

  const BlogDetailScreen({super.key, required this.blogId});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  void initState() {
    super.initState();
    GetIt.instance<BlogDetailBloc>()
        .add(BlogDetailRequested(blogId: widget.blogId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BlogAppBar(),
      body: BlocProvider.value(
        value: GetIt.instance<BlogDetailBloc>(),
        child: BlocBuilder<BlogDetailBloc, BlogDetailState>(
          builder: (context, state) {
            if (state is BlogDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BlogDetailFailed) {
              return const Center(
                child: Text('Error loading blog'),
              );
            }
            if (state is BlogDetailLoaded) {
              return Stack(
                children: [
                  BlogInfo(blog: state.blog),
                  Positioned(
                      bottom: 20,
                      right: 20,
                      child: FloatingActionButton(
                        shape: const CircleBorder(),
                        backgroundColor: const Color(0xFF4F14A0),
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0)),
                            ),
                            builder: (BuildContext context) {
                              return CustomModalSheet(
                                  blogId: widget.blogId,
                                  child: BlogComments(
                                    //TODO: Replace with comments from bloc
                                    comments: [
                                      Comment(
                                        id: '1',
                                        body: 'This is a great blog post!',
                                        user: 'User1',
                                        date: DateTime.now(),
                                      ),
                                      Comment(
                                        id: '1',
                                        body: 'I found this post very helpful.',
                                        user: 'User2',
                                        date: DateTime.now(),
                                      ),
                                      Comment(
                                        id: '1',
                                        body: 'Thanks for sharing this post.',
                                        user: 'User3',
                                        date: DateTime.now(),
                                      ),
                                    ],
                                  ));
                            },
                          );
                        },
                        child: const Icon(
                          Icons.comment_outlined,
                          color: Colors.white,
                        ),
                      )),
                ],
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
