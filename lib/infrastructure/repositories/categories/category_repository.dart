import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/category/category.dart';
import 'package:gymnastic_center/domain/category/category_repository.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';

class CategoryRepository implements ICategoryRepository {
  final IHttpManager _httpConnectionManager;

  CategoryRepository(this._httpConnectionManager);

  @override
  Future<Result<List<Category>>> getAllCategories() async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'category/many?page=1&perPage=15',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Category> categories = [];
        for (var category in data) {
          categories.add(Category(
            id: category['id'],
            name: category['name'],
            icon: category['icon'],
          ));
        }
        return categories;
      },
    );
    return result;
  }
}
