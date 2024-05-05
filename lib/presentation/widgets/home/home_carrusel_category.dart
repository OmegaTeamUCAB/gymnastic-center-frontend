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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Column(
            children: [
              CarouselHeader(
                title: 'Category of Yogas',
                onButtonPressed: () {
                  // Botón para ver todas las categorías
                },
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
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
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color.fromARGB(255, 245, 242, 242),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.network(currentCategory.icon),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              currentCategory.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
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
        }
      },
    );
  }
}
