import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/services/categories/category_service.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/home/category_carousel.dart';
import 'package:gymnastic_center/infrastructure/services/blogs/blogs_service.dart';
import 'package:gymnastic_center/presentation/widgets/home/blog_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 230), child: HomeAppBar()),
      body: Column(
        children: [
          CategoryCarousel(categoryRepository: CategoryService()),
          Expanded(
            child: BlogList(blogRepository: BlogsService()),
          ),
        ],
      ),
    );
  }
}
