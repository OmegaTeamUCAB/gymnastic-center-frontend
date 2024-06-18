import 'package:gymnastic_center/application/use_cases/user/update_user.use_case.dart';
import 'package:gymnastic_center/core/result.dart';

abstract class IUserRepository{
  Future<Result<void>> updateUser(UpdateUserDto dto);
}