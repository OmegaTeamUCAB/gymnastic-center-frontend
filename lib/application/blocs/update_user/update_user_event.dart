part of 'update_user_bloc.dart';

class UpdateUserEvent{
  const UpdateUserEvent();
}

class UpdateUser extends UpdateUserEvent{
  final String fullName;
  final String phoneNumber;
  final String email;
  final String image;
  const UpdateUser({required this.fullName,required this.phoneNumber,required this.email,required this.image});

}
