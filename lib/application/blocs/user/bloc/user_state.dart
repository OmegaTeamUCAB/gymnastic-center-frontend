part of 'user_bloc.dart';

class UserState {

  final String? name;
  final String? password;
  final String? email;
  final String? phone;
  final String? image;

  const UserState({
    this.name, 
    this.password, 
    this.email, 
    this.phone, 
    this.image
});
  
  UserState copyWith({
    String? name,
    String? password,
    String? email,
    String? phone,
    String? image,
  }) => UserState(
    name: name ?? this.name,
    password: password ?? this.password,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    image: image ?? this.image
  );
  
}



