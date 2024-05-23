part of 'user_bloc.dart';

class UserEvent{
  const UserEvent();
}

class UpdateUser extends UserEvent{
  final User user;
  const UpdateUser({required this.user});

}
