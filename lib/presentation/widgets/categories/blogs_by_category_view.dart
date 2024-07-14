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
  late PaginationController _paginationController;
  late BlogsByCategoryBloc _blogsByCategoryBloc;

  @override
  void initState() {
    super.initState();
    _blogsByCategoryBloc = GetIt.instance<BlogsByCategoryBloc>();
    _paginationController = PaginationController(
      requestNextPage: (page) {
        _blogsByCategoryBloc.add(
          BlogsByCategoryRequested(page: page, categoryId: widget.categoryId),
        );
      },
    );

    // Dispatch the first request
    _blogsByCategoryBloc.add(
      BlogsByCategoryRequested(page: 1, categoryId: widget.categoryId),
    );
  }

  @override
  void dispose() {
    _paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlogsByCategoryBloc>.value(
      value: _blogsByCategoryBloc,
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
              child: Padding(
                padding: EdgeInsets.all(15),
                child: NoResults(),
              ),
            );
          }
          return BlogsGrid(
            controller: _paginationController.scrollController,
            blogs: state.blogs,
          );
        } else {
          return const Center(
            child: Text('Error al cargar blogs'),
          );
        }
      }),
    );
  }
}
