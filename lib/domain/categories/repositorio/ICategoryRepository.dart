
import 'package:flutter_template/application/models/category.dart';

abstract class ICategoryRepository {
  Future<List<Category>> getAllCategories();
}