import 'package:gymnastic_center/domain/auth/user.dart';

abstract class IUserRepository{
  Future<void> editUser(User user);
}