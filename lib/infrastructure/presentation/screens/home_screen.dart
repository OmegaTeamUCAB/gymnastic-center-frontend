import 'package:flutter/material.dart';
import 'package:flutter_template/presentation/widgets/home/home_app_bar.dart';
import 'package:flutter_template/presentation/widgets/home/home_carrusel_category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 230), child: HomeAppBar()
            ),
        body: CategoryCarousel(categoryRepository: categoryService),
        );
  }
}
