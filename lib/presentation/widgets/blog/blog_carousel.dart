import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_blogs/all_blogs_bloc.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_slide.dart';

class BlogCarousel extends StatelessWidget {
  const BlogCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final allBlogsBloc = GetIt.instance<AllBlogsBloc>();
    // TODO: Implement pagination
    allBlogsBloc.add(const AllBlogsRequested(1));
    return BlocProvider<AllBlogsBloc>.value(
      value: allBlogsBloc,
      child: BlocBuilder<AllBlogsBloc, AllBlogsState>(
        builder: (context, state) {
          if (state is AllBlogsLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is AllBlogsFailed) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is AllBlogsSuccess) {
            List<Blog> blogs = state.blogs;
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
