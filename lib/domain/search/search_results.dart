import 'package:gymnastic_center/application/models/blog.dart';
import 'package:gymnastic_center/domain/course/course.dart';

class SearchResults {
  final Course? course;
  final Blog? blog;

  SearchResults(this.course, this.blog);
}
