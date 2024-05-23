part of 'user_bloc.dart';

class UserState {

  final String? name;
  final String? email;
  final String? phone;
  final String? image;

  const UserState({
    this.name,  
    this.email, 
    this.phone, 
    this.image
});
  
  UserState copyWith({
    String? name,
    String? email,
    String? phone,
    String? image,
  }) => UserState(
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    image: image ?? this.image
  );
  
}



