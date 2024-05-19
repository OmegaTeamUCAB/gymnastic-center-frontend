import 'package:gymnastic_center/domain/search/search_results.dart';

abstract class ISearchRepository {
  Future<SearchResults> search(String searchTerm);
}
