import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_blogs/all_blogs_bloc.dart';
import 'package:gymnastic_center/application/blocs/blogs_by_category/blogs_by_category_bloc.dart';
import 'package:gymnastic_center/presentation/utils/pagination_controller.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blogs_grid.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';

class AllBlogsScreen extends StatefulWidget {
  const AllBlogsScreen({super.key});

  @override
  State<AllBlogsScreen> createState() => _AllBlogsScreenState();
}

class _AllBlogsScreenState extends State<AllBlogsScreen> {
  late PaginationController _paginationController;
  late AllBlogsBloc _allBlogsBloc;

  @override
  void initState() {
    super.initState();
    _allBlogsBloc = GetIt.instance<AllBlogsBloc>();
    _paginationController = PaginationController(
      requestNextPage: (page) {
        // _allBlogsBloc.add(
        //   AllBlogsRequested(page),
        // );
      },
    );

    // Dispatch the first request
    _allBlogsBloc.add(
      const AllBlogsRequested(1),
    );
  }

  @override
  void dispose() {
    _paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    BrandBackButton(),
                    Text(
                      'All Blogs',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ),
        ),
        body: BlocProvider<AllBlogsBloc>.value(
          value: _allBlogsBloc,
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
              if (state.blogs.isEmpty) {
                return const Center(
                  child: NoResults(),
                );
              }
              return BlogsGrid(
                blogs: state.blogs,
                controller: _paginationController.scrollController,
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          }),
        ));
  }
}
