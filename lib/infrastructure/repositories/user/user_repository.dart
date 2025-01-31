import 'package:gymnastic_center/application/use_cases/user/update_user.use_case.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/auth/user_repository.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';

class UserRepository extends IUserRepository {
  final IHttpManager _httpConnectionManager;

  UserRepository(this._httpConnectionManager);

  @override
  Future<Result<void>> updateUser(UpdateUserDto dto) async {
    final result = await _httpConnectionManager.makeRequest(
        urlPath: '/user/update',
        httpMethod: 'PUT',
        mapperCallBack: (data) {
          return data;
        },
        body: {
          'name': dto.fullName,
          'phone': dto.phoneNumber,
          'image': dto.image
        });
    return result;
  }

  @override
  Future<Result<int>> trainerUserFollow() async {
    final result = await _httpConnectionManager.makeRequest(
        urlPath: '/trainer/user/follow',
        httpMethod: 'GET',
        mapperCallBack: (data) {
          final count = data['count'] as int;
          return count;
        });
    if (result.isSuccessful) {
      return Result.success(result.unwrap());
    } else {
      return Result.failure(result.error);
    }
  }
}
