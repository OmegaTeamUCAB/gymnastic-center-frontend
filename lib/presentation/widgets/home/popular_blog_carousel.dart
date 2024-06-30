import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/popular_blogs/popular_blogs_bloc.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_carousel.dart';

class PopularBlogCarousel extends StatelessWidget {
  const PopularBlogCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final popularBlogsBloc = GetIt.instance<PopularBlogsBloc>();
    popularBlogsBloc.add(const PopularBlogsRequested(1));
    return BlocProvider<PopularBlogsBloc>.value(
      value: popularBlogsBloc,
      child: BlocBuilder<PopularBlogsBloc, PopularBlogsState>(
        builder: (context, state) {
          if (state is PopularBlogsLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is PopularBlogsFailed) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is PopularBlogsSuccess) {
            List<Blog> blogs = state.blogs;
            return BlogCarousel(blogs: blogs);
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
