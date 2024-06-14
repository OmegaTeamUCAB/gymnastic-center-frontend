import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_course_by_trainer/all_course_by_trainer_bloc.dart';
import 'package:gymnastic_center/presentation/utils/pagination_controller.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';
import 'package:gymnastic_center/presentation/widgets/course/courses_list.dart';

class AllCoursesByTrainerScreen extends StatefulWidget {
  final Map trainer;
  const AllCoursesByTrainerScreen({super.key, required this.trainer});

  @override
  State<AllCoursesByTrainerScreen> createState() =>
      _AllCoursesByTrainerScreenState();
}

class _AllCoursesByTrainerScreenState extends State<AllCoursesByTrainerScreen> {
  // final allCoursesByTrainerBloc = GetIt.instance<AllCourseByTrainerBloc>();
  late PaginationController _paginationController;
  late AllCourseByTrainerBloc _allCoursesByTrainerBloc;

  @override
  void initState() {
    super.initState();
    _allCoursesByTrainerBloc = GetIt.instance<AllCourseByTrainerBloc>();

    _paginationController = PaginationController(
      requestNextPage: (page) {},
    );

    _allCoursesByTrainerBloc.add(
      AllCourseByTrainerRequested(widget.trainer['id'], 1),
    );
  }

  @override
  void dispose() {
    _paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.trainer['id'];
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
                      'All Courses by $name',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ),
        ),
        body: BlocProvider<AllCourseByTrainerBloc>.value(
          value: _allCoursesByTrainerBloc,
          child: BlocBuilder<AllCourseByTrainerBloc, AllCourseByTrainerState>(
            builder: (context, state) {
              if (state is AllCourseByTrainerLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is AllCourseByTrainerFailed) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is AllCoursesByTrainerSuccess) {
                if (state.courses.isEmpty) {
                  return const Center(
                    child: NoResults(),
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
        ));
  }
}
