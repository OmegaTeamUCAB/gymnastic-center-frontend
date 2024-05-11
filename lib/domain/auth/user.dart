class User {
  final Map<String, dynamic> data;

  User(this.data);

  String get id => data['id'];
  String get fullName => data['fullName'];
  String get email => data['email'];
  String get phoneNumber => data['phoneNumber'];
  String get stats => data['stats'];
  // ... other getters ...

  static User fromJson(Map<String, dynamic> json) => User(json);

  static List<User> fromJsonToList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }
}
