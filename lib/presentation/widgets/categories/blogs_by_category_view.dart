import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/blogs_by_category/blogs_by_category_bloc.dart';
import 'package:gymnastic_center/application/blocs/blogs_by_category/blogs_by_category_event.dart';
import 'package:gymnastic_center/presentation/utils/pagination_controller.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blogs_grid.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';

class BlogsByCategoryView extends StatefulWidget {
  final String categoryId;

  const BlogsByCategoryView({super.key, required this.categoryId});

  @override
  State<BlogsByCategoryView> createState() => _BlogsByCategoryViewState();
}

class _BlogsByCategoryViewState extends State<BlogsByCategoryView> {
  late final PaginationController paginationController;
  final blogsByCategoryBloc = GetIt.instance<BlogsByCategoryBloc>();

  @override
  void initState() {
    super.initState();
    //! Buggy as hell
    paginationController = PaginationController(
      requestNextPage: (page) => blogsByCategoryBloc.add(
          BlogsByCategoryRequested(categoryId: widget.categoryId, page: 1)),
    );
  }

  @override
  void dispose() {
    paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlogsByCategoryBloc>.value(
      value: blogsByCategoryBloc,
      child: BlocBuilder<BlogsByCategoryBloc, BlogsByCategoryState>(
          builder: (context, state) {
        if (state is BlogsByCategoryLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is BlogsByCategoryFailed) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is BlogsByCategorySuccess) {
          if (state.blogs.isEmpty) {
            return const Center(
              child: NoResults(),
            );
          }
          return BlogsGrid(
            blogs: state.blogs,
            controller: paginationController.scrollController,
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      }),
    );
  }
}
