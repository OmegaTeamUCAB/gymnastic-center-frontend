import 'dart:convert';
import 'package:flutter_template/application/models/category.dart';
import 'package:flutter_template/domain/categories/repositorio/ICategoryRepository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryService implements ICategoryRepository {

  @override
  Future<List<Category>> getAllCategories() async {
  final response = await http.get(Uri.parse('${dotenv.env['API_URL']}/categories'));

  if (response.statusCode == 200) {
    List<Category> categories = [];
    var data = jsonDecode(response.body);
    for (var category in data) {
      categories.add(Category(
        id: category['id'],
        name: category['name'],
        icon: category['icon'],
      ));
    }
    return categories;
  } else {
    throw Exception('Failed to load categories');
  }
}

}