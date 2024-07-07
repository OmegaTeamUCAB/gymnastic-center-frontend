import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/presentation/screens/blog/all_blogs_screen.dart';
import 'package:gymnastic_center/presentation/screens/course/all_courses_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/main_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/common/content_header.dart';

import 'package:gymnastic_center/presentation/widgets/home/category_carousel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_course_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/home/last_course_percentage.dart';
import 'package:gymnastic_center/presentation/widgets/home/popular_blog_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(openDrawer: () => Scaffold.of(context).openDrawer()),
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          LastCoursePercentage(
              course: Course(
                  id: '1',
                  name: 'Algun curso de prueba',
                  imageUrl: 'something',
                  trainer: 'Test trainer',
                  category: 'Whatever'),
              percentage: 50),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              AppLocalizations.of(context)!.categories,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          const CategoryCarousel(),
          const SizedBox(
            height: 15,
          ),
          ContentHeader(
              title: AppLocalizations.of(context)!.trendingCourses,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllCoursesScreen()),
                );
              }),
          const HomeCourseCarousel(),
          const SizedBox(
            height: 25,
          ),
          ContentHeader(
              title: AppLocalizations.of(context)!.popularBlogs,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllBlogsScreen()),
                );
              }),
          const SizedBox(
            height: 10,
          ),
          const PopularBlogCarousel(),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
