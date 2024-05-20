import 'dart:convert';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/category/category.dart';
import 'package:gymnastic_center/domain/category/category_repository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryRepository implements ICategoryRepository {
  @override
  Future<Result<List<Category>>> getAllCategories() async {
    final response =
        await http.get(Uri.parse('${dotenv.env['API_URL']}/categories'));

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
      return Result.success(categories);
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
