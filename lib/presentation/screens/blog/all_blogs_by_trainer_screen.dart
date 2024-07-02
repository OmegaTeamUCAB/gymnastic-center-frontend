import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_blogs_by_trainer/all_blogs_by_trainer_bloc.dart';
import 'package:gymnastic_center/presentation/utils/pagination_controller.dart';
import 'package:gymnastic_center/presentation/widgets/blog/blogs_grid.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';

class AllBlogsByTrainerScreen extends StatefulWidget {
  final Map trainer;
  const AllBlogsByTrainerScreen({super.key, required this.trainer});

  @override
  State<AllBlogsByTrainerScreen> createState() =>
      _AllBlogsByTrainerScreenState();
}

class _AllBlogsByTrainerScreenState extends State<AllBlogsByTrainerScreen> {
  late PaginationController _paginationController;
  late AllBlogsByTrainerBloc _allBlogsByTrainerBloc;
  // final allBlogsByTrainerBloc = GetIt.instance<AllBlogsByTrainerBloc>();

  @override
  void initState() {
    super.initState();
    _allBlogsByTrainerBloc = GetIt.instance<AllBlogsByTrainerBloc>();
    _paginationController = PaginationController(
      requestNextPage: (page) {},
    );

    _allBlogsByTrainerBloc.add(
      AllBlogsByTrainerRequested(widget.trainer['id'], 1),
    );
  }

  @override
  void dispose() {
    _paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.trainer['name'];
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    const BrandBackButton(),
                    Text(
                      'All Blogs by $name',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ),
        ),
        body: BlocProvider<AllBlogsByTrainerBloc>.value(
          value: _allBlogsByTrainerBloc,
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
