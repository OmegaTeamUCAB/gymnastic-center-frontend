import 'package:flutter_template/domain/categories/repositorio/ICategoryRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/application/models/category.dart';
class SuperiorWidget extends StatelessWidget {
  final String title;
  final VoidCallback onButtonPressed;

  const SuperiorWidget({super.key, required this.title, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
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
                    child: const Text('See all >', style: TextStyle(color: Colors.black)),
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
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color.fromARGB(255, 245, 242, 242),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido
                          children: [
                            Flexible(
                           child: SizedBox(
                              height: 50,
                              width: 50,
                           child: Image.network(currentCategory.icon), 
                            ),),// Muestra el icono de la categoría
                            const SizedBox(height: 10.0), // Agrega espacio entre el icono y el texto
                            Text(
                              currentCategory.name, // Muestra el nombre de la categoría
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