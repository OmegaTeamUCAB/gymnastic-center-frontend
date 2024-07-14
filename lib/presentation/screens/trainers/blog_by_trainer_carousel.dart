import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_blogs_by_trainer/all_blogs_by_trainer_bloc.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blog_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';

class BlogByTrainerCarousel extends StatefulWidget {
  final String trainerId;
  const BlogByTrainerCarousel({
    super.key,
    required this.trainerId,
  });

  @override
  State<BlogByTrainerCarousel> createState() => _BlogByTrainerCarouselState();
}

class _BlogByTrainerCarouselState extends State<BlogByTrainerCarousel> {
  late final AllBlogsByTrainerBloc _blogBloc;
  @override
  void initState() {
    super.initState();
    _blogBloc = GetIt.instance<AllBlogsByTrainerBloc>();
    _blogBloc.add(AllBlogsByTrainerRequested(widget.trainerId, 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _blogBloc,
      child: BlocBuilder<AllBlogsByTrainerBloc, AllBlogsByTrainerState>(
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
            if (state.blogs.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 20),
                child: NoResults(message: 'No blogs found'),
              );
            }
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
