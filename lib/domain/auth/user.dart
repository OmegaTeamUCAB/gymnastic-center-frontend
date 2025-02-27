class User {
  final Map<String, dynamic> data;

  User(this.data);

  String get id => data['id'];
  String get fullName => data['name'];
  String get email => data['email'];
  String get phoneNumber => data['phone'];
  String? get image => data['image'];
  String get stats => data['stats'];

  static User fromJson(Map<String, dynamic> json) => User(json);

  static List<User> fromJsonToList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }
}
