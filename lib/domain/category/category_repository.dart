import 'package:gymnastic_center/domain/category/category.dart';

abstract class ICategoryRepository {
  Future<List<Category>> getAllCategories();
}
