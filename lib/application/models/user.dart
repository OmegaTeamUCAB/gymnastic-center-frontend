class User {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String gender;
  final List<String> stats;

  User(this.id, this.name, this.lastName, this.email, this.phoneNumber,
      this.password, this.gender, this.stats);
}
