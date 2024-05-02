import 'dart:convert';
import 'package:flutter_template/application/models/category.dart';
import 'package:flutter_template/domain/categories/repositorio/ICategoryRepository.dart';
import 'package:http/http.dart' as http;

class CategoryService implements ICategoryRepository {

  @override
  Future<List<Category>> getAllCategories() async {
  final response = await http.get(Uri.parse('https://gymnastic-center-uo53v.ondigitalocean.app/categories'));

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