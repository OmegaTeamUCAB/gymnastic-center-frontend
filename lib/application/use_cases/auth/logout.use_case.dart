import 'package:gymnastic_center/application/services/data-sources/local_data_source.dart';
import 'package:gymnastic_center/core/exception.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';

class LogoutUseCase extends IUseCase<void, bool> {
  final LocalDataSource _localDataSource;
  LogoutUseCase({required LocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<Result<bool>> execute(void dto) async {
    try {
      await _localDataSource.removeKey('token');
      return Result.success<bool>(true);
    } catch (e) {
      return Result.failure<bool>(const UnknownException());
    }
  }
}
