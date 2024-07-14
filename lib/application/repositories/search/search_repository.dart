import 'package:gymnastic_center/application/repositories/search/search_results.dart';
import 'package:gymnastic_center/application/use_cases/search/get_search_tags.use_case.dart';
import 'package:gymnastic_center/application/use_cases/search/search.use_case.dart';
import 'package:gymnastic_center/core/result.dart';

abstract class ISearchRepository {
  Future<Result<SearchResults>> search(SearchDto searchDto);
  Future<Result<List<String>>> getSearchTags(SearchTagsDto searchTagsDto);
}
