import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/plan_courses/plan_courses_bloc.dart';
import 'package:gymnastic_center/application/blocs/plan_courses/plan_courses_event.dart';
import 'package:gymnastic_center/application/blocs/plan_courses/plan_courses_state.dart';
import 'package:gymnastic_center/presentation/screens/loading_screen.dart';
import 'package:gymnastic_center/presentation/widgets/training/plan_courses_page_view.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final planCoursesBloc = GetIt.instance<PlanCoursesBloc>();
    planCoursesBloc.add(const PlanCoursesRequested(1, 'userId'));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          image: const DecorationImage(
            image: AssetImage(
                "assets/particles.png"), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: BlocProvider<PlanCoursesBloc>.value(
          value: planCoursesBloc,
          child: BlocBuilder<PlanCoursesBloc, PlanCoursesState>(
            builder: (context, state) {
              if (state is PlanCoursesLoading) {
                return const LoadingScreen();
              }
              if (state is PlanCoursesFailed) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is PlanCoursesSuccess) {
                return PlanCoursesPageView(courses: state.courses);
              } else {
                return const Center(
                  child: Text('Unexpected error'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
