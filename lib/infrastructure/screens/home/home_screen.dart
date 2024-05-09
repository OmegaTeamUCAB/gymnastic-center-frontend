import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/services/categories/CategoryService.dart';
import 'package:gymnastic_center/presentation/widgets/home/category_carousel.dart';
import 'package:gymnastic_center/infrastructure/services/blogs/BlogsService.dart';
import 'package:gymnastic_center/presentation/widgets/home/BlogList.dart';
import 'package:gymnastic_center/presentation/widgets/home/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 230), child: HomeAppBar()),
body: Column(
        children: [
          CategoryCarousel(categoryRepository: CategoryService()),
          SizedBox(height: 20), 
           Expanded(
    child: BlogList(blogRepository: BlogsService()),
  ),
        ],
      ),
              );
            }
          }
