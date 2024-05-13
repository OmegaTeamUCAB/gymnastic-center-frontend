import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/datasources/http/http_manager_impl.dart';
import 'package:gymnastic_center/infrastructure/services/blogs/blogs_service.dart';
import 'package:gymnastic_center/presentation/widgets/categories/improved_blog_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final String categoryId;
  //todo: add the blogs-by-category bloc
  const CategoryScreen(
      {super.key, required this.categoryName, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: CustomAppBar(
          content: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.chevron_left,
                      size: 30, color: Colors.white)),
              Text(
                categoryName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Popular Blogs',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          ImprovedBlogCarousel(
              blogRepository: BlogsService(HttpManagerImpl(
            baseUrl: Environment.getApiUrl(),
          )))
        ],
      ),
    );
  }
}
