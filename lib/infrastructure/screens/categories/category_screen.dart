import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/blogs/blogs_repository.dart';
import 'package:gymnastic_center/presentation/data/dummy_courses.dart';
import 'package:gymnastic_center/presentation/widgets/categories/blogs_grid.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_chip.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_course_card.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  //todo: add the blogs-by-category bloc
  const CategoryScreen(
      {super.key, required this.categoryName, required this.categoryId});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String selectedChip = 'Courses';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 130),
        child: CustomAppBar(
          content: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.chevron_left,
                          size: 30, color: Colors.white)),
                  Text(
                    widget.categoryName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomChip(
                    label: "Courses",
                    isSelected: selectedChip == 'Courses',
                    onTap: (isSelected) {
                      setState(() {
                        selectedChip = 'Courses';
                      });
                    },
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  CustomChip(
                    label: "Blogs",
                    isSelected: selectedChip == 'Blogs',
                    onTap: (isSelected) {
                      setState(() {
                        selectedChip = 'Blogs';
                      });
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                selectedChip == 'Blogs' ? '81 Blogs' : '40 Cursos',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            selectedChip == 'Blogs'
                ? BlogsGrid(
                    blogRepository: BlogsRepository(HttpManagerImpl(
                    baseUrl: Environment.getApiUrl(),
                  )))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dummyCourses.length,
                      itemBuilder: (context, index) {
                        return HomeCourseCard(course: dummyCourses[index]);
                      },
                    ),
                  ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
