part of 'update_user_bloc.dart';

class UpdateUserEvent {
  const UpdateUserEvent();
}

class UpdatedUser extends UpdateUserEvent {
  final String fullName;
  final String phoneNumber;
  final String? image;
  const UpdatedUser(
      {required this.fullName, required this.phoneNumber, this.image});
}
