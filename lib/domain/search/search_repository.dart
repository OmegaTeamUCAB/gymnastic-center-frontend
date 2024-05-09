import 'package:gymnastic_center/domain/search/search_results.dart';

abstract class SearchRepository {
  Future<SearchResults> search(String searchTerm);
}
