import 'package:flutter_template/infrastructure/services/categories/CategoryService.dart';
import 'package:flutter_template/domain/categories/repositorio/ICategoryRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/application/models/category.dart';

CategoryService categoryService = CategoryService();

FutureBuilder<List<Category>> futureBuilder = FutureBuilder<List<Category>>(
  future:categoryService.getAllCategories(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return CategoryCarousel(categoryRepository: categoryService);
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }
    return CircularProgressIndicator();
  },
);


class SuperiorWidget extends StatelessWidget {
  final String title;
  final VoidCallback onButtonPressed;

  SuperiorWidget({required this.title, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        Padding(
            padding: const EdgeInsets.only(top: 8.0), // Ajusta el relleno superior para mover el botón hacia abajo
            child: TextButton(
              onPressed: onButtonPressed,
                 child: InkWell(
      onTap: onButtonPressed,
      splashColor: Colors.transparent, // Elimina el efecto de oscurecimiento al presionar el botón
      child: Text('See all >', style: TextStyle(color: Colors.black)),
    ),
             
              
            ),
          ),
        ],
      ),
    );
  }
}


class CategoryCarousel extends StatelessWidget {
final ICategoryRepository categoryRepository;

  CategoryCarousel({required this.categoryRepository});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: categoryRepository.getAllCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Column(
            children: [
              SuperiorWidget(
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
                    Category currentCategory = snapshot.data![index]; // Obtiene la categoría actual
                    return GestureDetector(
                      onTap: () {
                        // Acción al tocar la categoría
                      },
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color.fromARGB(255, 245, 242, 242),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido
                          children: [
                            Flexible(
                           child: Container(
                              height: 50,
                              width: 50,
                           child: Image.network(currentCategory.icon), 
                            ),),// Muestra el icono de la categoría
                            SizedBox(height: 10.0), // Agrega espacio entre el icono y el texto
                            Text(
                              currentCategory.name, // Muestra el nombre de la categoría
                              style: TextStyle(
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