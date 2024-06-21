import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/courses_by_category/courses_by_category_bloc.dart';
import 'package:gymnastic_center/presentation/utils/pagination_controller.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';
import 'package:gymnastic_center/presentation/widgets/course/courses_list.dart';

class CoursesByCategoryView extends StatefulWidget {
  final String categoryId;

  const CoursesByCategoryView({super.key, required this.categoryId});

  @override
  State<CoursesByCategoryView> createState() => _CoursesByCategoryViewState();
}

class _CoursesByCategoryViewState extends State<CoursesByCategoryView> {
  late PaginationController _paginationController;
  late CoursesByCategoryBloc _coursesByCategoryBloc;

  @override
  void initState() {
    super.initState();
    _coursesByCategoryBloc = GetIt.instance<CoursesByCategoryBloc>();
    _paginationController = PaginationController(
      requestNextPage: (page) {
        _coursesByCategoryBloc.add(
          CoursesByCategoryRequested(categoryId: widget.categoryId, page: page),
        );
      },
    );

    // Dispatch the first request
    _coursesByCategoryBloc.add(
      CoursesByCategoryRequested(categoryId: widget.categoryId, page: 1),
    );
  }

  @override
  void dispose() {
    _paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CoursesByCategoryBloc>.value(
      value: _coursesByCategoryBloc,
      child: BlocBuilder<CoursesByCategoryBloc, CoursesByCategoryState>(
        builder: (context, state) {
          if (state is CoursesByCategoryLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is CoursesByCategoryFailed) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is CoursesByCategorySuccess) {
            if (state.courses.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: NoResults(),
                ),
              );
            }
            return CoursesList(
              courses: state.courses,
              controller: _paginationController.scrollController,
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
