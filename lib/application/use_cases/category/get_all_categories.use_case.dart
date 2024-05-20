import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/category/category.dart';
import 'package:gymnastic_center/domain/category/category_repository.dart';

class GetAllCategoriesDto {
  GetAllCategoriesDto();
}

class GetAllCategoriesUseCase
    extends IUseCase<GetAllCategoriesDto, List<Category>> {
  final ICategoryRepository categoryRepository;

  GetAllCategoriesUseCase(this.categoryRepository);

  @override
  Future<Result<List<Category>>> execute(GetAllCategoriesDto dto) async {
    return await categoryRepository.getAllCategories();
  }
}
