import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';
import 'package:gymnastic_center/presentation/screens/blog/all_blogs_screen.dart';
import 'package:gymnastic_center/presentation/screens/course/all_courses_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/home/blog_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/common/content_header.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_course_carousel.dart';

class TrainerInfo extends StatelessWidget {
  final Trainer trainer;
  final ScrollController scrollController;
  final bool showFab;
  const TrainerInfo(
      {super.key,
      required this.trainer,
      required this.scrollController,
      required this.showFab});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'https://images.unsplash.com/photo-1623200216581-969d9479cf7d?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          height: 400,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return child;
            }
          },
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
          controller: scrollController,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            margin: const EdgeInsets.only(top: 365),
            child: Column(
              children: [
                Center(child: Text('${trainer.name} fitness')),
                const SizedBox(height: 25),
                ContentHeader(
                    title: '${trainer.name}\'s Courses',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllCoursesScreen()),
                      );
                    }),
                const HomeCourseCarousel(),
                ContentHeader(
                    title: '${trainer.name}\'s Blogs',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllBlogsScreen()),
                      );
                    }),
                const HomeBlogCarousel(),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            left: 0,
            right: 0,
            top: showFab ? 0 : -140,
            child: Container(
              height: 110,
              width: double.infinity,
              color: const Color(0xFF4F14A0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    trainer.name!,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            )),
        Positioned(
            top: 60,
            left: 10,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF4F14A0),
                shape: BoxShape.circle,
              ),
              child: const BrandBackButton(
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}
