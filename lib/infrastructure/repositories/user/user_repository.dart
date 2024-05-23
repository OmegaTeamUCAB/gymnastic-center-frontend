
import 'package:dio/dio.dart';
import 'package:gymnastic_center/domain/auth/user.dart';
import 'package:gymnastic_center/domain/auth/user_repository.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';

class UserRepository extends IUserRepository{

  final Dio dio = Dio(BaseOptions(
    baseUrl: Environment.getApiUrl(),
  ));

  @override
  Future<void> editUser(User user) {
    //TODO: implement repository
    throw UnimplementedError();
  }

}