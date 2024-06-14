import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/category/category.dart';

abstract class ICategoryRepository {
  Future<Result<List<Category>>> getAllCategories();
}
