class Course {
  final Map<String, dynamic> data;

  Course(this.data);

  String get id => data['id'];
  String get title => data['title'];
  String get description => data['description'];
  String get imageUrl => data['imageUrl'];
  // ... other getters ...

  static Course fromJson(Map<String, dynamic> json) => Course(json);

  static List<Course> fromJsonToList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }
}

class Blog {
  final Map<String, dynamic> data;

  Blog(this.data);

  String get id => data['id'];
  String get title => data['title'];
  String get description => data['description'];
  String get imageUrl => data['imageUrl'];
  // ... other getters ...

  static Blog fromJson(Map<String, dynamic> json) => Blog(json);

  static List<Blog> fromJsonToList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }
}

class SearchResults {
  final List<Course> courses;
  final List<Blog> blogs;

  const SearchResults({this.courses = const [], this.blogs = const []});
}
