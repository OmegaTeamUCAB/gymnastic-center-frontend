import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/course/course.dart';

class SearchResults {
  final List<Course> courses;
  final List<Blog> blogs;

  const SearchResults({this.courses = const [], this.blogs = const []});
}
