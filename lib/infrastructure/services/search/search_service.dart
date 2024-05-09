import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gymnastic_center/infrastructure/mappers/blog/blog_mapper.dart';
import 'package:gymnastic_center/infrastructure/mappers/course/course_mapper.dart';
import 'package:http/http.dart' as http;
import 'package:gymnastic_center/domain/search/search_repository.dart';
import 'package:gymnastic_center/domain/search/search_results.dart';

class SearchService implements SearchRepository {
  @override
  Future<SearchResults> search(String searchTerm) async {
    final url = Uri.parse('${dotenv.env['API_URL']}/search/$searchTerm');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final searchData = jsonDecode(response.body);
        final courses = CourseMapper.fromJsonToList(searchData['courses']);
        final blogs = BlogMapper.fromJsonToList(searchData['blogs']);
        return SearchResults(courses: courses, blogs: blogs);
      } else {
        throw Exception(
            'Search failed with status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Network error occurred.');
    } catch (e) {
      rethrow;
    }
  }
}
