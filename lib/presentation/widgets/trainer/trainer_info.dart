import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';
import 'package:gymnastic_center/presentation/screens/blog/all_blogs_screen.dart';
import 'package:gymnastic_center/presentation/screens/course/all_courses_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_blog_carousel.dart';
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
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541',
          height: 200,
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
            margin: const EdgeInsets.only(top: 165),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  trainer.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      trainer.followers.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' ${trainer.followers == 1 ? 'follower' : 'followers'}',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: BrandButton(
                    text: 'Seguir',
                    onPressed: () {},
                  ),
                ),
                ContentHeader(
                    title: '${trainer.name}\'s Courses',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllCoursesScreen()),
                      );
                    }),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: HomeCourseCarousel(),
                ),
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
