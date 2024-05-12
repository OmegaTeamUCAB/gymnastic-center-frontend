import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/course/course_bloc.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/datasources/http/http_manager_impl.dart';
import 'package:gymnastic_center/infrastructure/services/blogs/blogs_service.dart';
import 'package:gymnastic_center/infrastructure/services/categories/category_service.dart';
import 'package:gymnastic_center/presentation/widgets/course/course_carrusel.dart';
import 'package:gymnastic_center/presentation/widgets/home/category_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/home/blog_list.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final popularCourses = context.watch<CourseBloc>().state.popularCourses;

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 170), child: HomeAppBar()),
      body: Column(
        children: [
          CategoryCarousel(categoryRepository: CategoryService()),
          const SizedBox(height: 20),
          Expanded(
              child: BlogList(
                  blogRepository: BlogsService(HttpManagerImpl(
            baseUrl: Environment.getApiUrl(),
          )))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CourseCarrusel(
                courses: popularCourses,
              )),
        ],
      ),
    );
  }
}
