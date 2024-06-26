class SearchResults {
  final List<SearchHit> courses;
  final List<SearchHit> blogs;

  const SearchResults({this.courses = const [], this.blogs = const []});
}

class SearchHit {
  final String id;
  final String title;
  final String image;
  final String category;
  final String trainer;

  const SearchHit(
      {required this.id,
      required this.title,
      required this.category,
      required this.trainer,
      required this.image});
}
