import 'package:gymnastic_center/application/repositories/search/search_repository.dart';
import 'package:gymnastic_center/application/repositories/search/search_results.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';

class SearchDto {
  final String searchTerm;
  final List<String> tags;
  final int page;
  final int perPage;
  SearchDto(this.searchTerm, this.tags, this.page, this.perPage);
}

class SearchUseCase extends IUseCase<SearchDto, SearchResults> {
  final ISearchRepository searchRepository;

  SearchUseCase(this.searchRepository);

  @override
  Future<Result<SearchResults>> execute(SearchDto dto) async {
    return await searchRepository.search(dto);
  }
}
