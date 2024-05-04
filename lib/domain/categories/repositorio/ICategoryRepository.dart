
import 'package:gymnastic_center/application/models/category.dart';

abstract class ICategoryRepository {
  Future<List<Category>> getAllCategories();
}