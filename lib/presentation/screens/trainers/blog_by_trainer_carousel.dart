import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_blogs_by_trainer/all_blogs_by_trainer_bloc.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_carousel.dart';

class BlogByTrainerCarousel extends StatelessWidget {
  final String trainerId;
  const BlogByTrainerCarousel({
    super.key,
    required this.trainerId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllBlogsByTrainerBloc, AllBlogsByTrainerState>(
      builder: (context, state) {
        if (state is AllBlogsByTrainerLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is AllBlogsByTrainerFailed) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is AllBlogsByTrainerSuccess) {
          List<Blog> blogs = state.blogs;
          return BlogCarousel(blogs: blogs);
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
