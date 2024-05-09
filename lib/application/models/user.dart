class User {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final List<dynamic>? stats;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.stats,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      stats: json['stats'],
    );
  }
}
