import 'package:gymnastic_center/domain/categories/repositorio/ICategoryRepository.dart';
import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/models/category.dart';
import 'package:gymnastic_center/presentation/widgets/common/carousel_header.dart';

class CategoryCarousel extends StatelessWidget {
  final ICategoryRepository categoryRepository;

  const CategoryCarousel({super.key, required this.categoryRepository});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: categoryRepository.getAllCategories(),
      builder: (context, snapshot) {
        return Column(
          children: [
            CarouselHeader(
              title: 'Categories',
              onButtonPressed: () {},
            ),
            SizedBox(
              height: 100,
              child: snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Category currentCategory = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            // Acción al tocar la categoría
                          },
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(
                                left: 15,
                                right: index == snapshot.data!.length - 1
                                    ? 15
                                    : 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Theme.of(context).colorScheme.surfaceTint,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.network(currentCategory.icon),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  currentCategory.name,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
