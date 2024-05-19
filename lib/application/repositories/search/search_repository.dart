import 'package:gymnastic_center/application/repositories/search/search_results.dart';

abstract class ISearchRepository {
  Future<SearchResults> search(String searchTerm);
}
