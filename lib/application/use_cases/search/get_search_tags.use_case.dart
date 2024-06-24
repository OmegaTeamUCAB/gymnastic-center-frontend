import 'package:gymnastic_center/application/repositories/search/search_repository.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';

class SearchTagsDto {
  SearchTagsDto();
}

class GetSearchTagsUseCase extends IUseCase<SearchTagsDto, dynamic> {
  final ISearchRepository searchRepository;

  GetSearchTagsUseCase(this.searchRepository);

  @override
  Future<Result<dynamic>> execute(SearchTagsDto dto) async {
    return await searchRepository.getSearchTags();
  }
}
