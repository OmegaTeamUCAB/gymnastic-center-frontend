import 'package:gymnastic_center/application/repositories/search/search_results.dart';
import 'package:gymnastic_center/core/result.dart';

abstract class ISearchRepository {
  Future<Result<SearchResults>> search(String searchTerm);
}
