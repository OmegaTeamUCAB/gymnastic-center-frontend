import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/infrastructure/screens/course/course_category_screen.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_carrusel.dart';
import 'package:gymnastic_center/infrastructure/services/categories/CategoryService.dart';
import 'package:gymnastic_center/presentation/widgets/common/carousel_header.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/home/category_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final popularCourses = context.watch<CourseBloc>().state.popularCourses;

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 230), child: HomeAppBar()),
      body: Column(
        children: [
          CategoryCarousel(categoryRepository: CategoryService()),
          CarouselHeader(
            title: 'Popular courses',
            onButtonPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CourseCategoryScreen(
                          categoryRepository: CategoryService(),
                        )),
              );
              ;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CourseCarrusel(
              courses: popularCourses,
            ),
          )
        ],
      ),
    );
  }
}
