
import 'package:dio/dio.dart';
import 'package:gymnastic_center/domain/auth/user.dart';
import 'package:gymnastic_center/domain/auth/user_repository.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';

class UserRepository extends IUserRepository{

  final Dio dio = Dio(BaseOptions(
    baseUrl: Environment.getApiUrl(),
  ));

  @override
  Future<User> editUser(Map<String, dynamic> user) async{
   try{
    const String url = '/users/update';
    final response = await dio.put(url,data: user);
    final users = User.fromJson(response.data);
    return users;
   }
   catch (e){
    throw Exception();
   }
  }

}