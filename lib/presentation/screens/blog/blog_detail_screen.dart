import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/blog_detail/blog_detail_bloc.dart';
import 'package:gymnastic_center/presentation/screens/blog/blog_info.dart';
import 'package:gymnastic_center/presentation/widgets/comment/comments_fab.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_app_bar.dart';

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
                      child: CommentsFAB(
                        blogId: widget.blogId,
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
