import 'package:gymnastic_center/application/services/datasources/local_datasource.dart';
import 'package:gymnastic_center/core/exception.dart';
import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';

class LogoutUseCase extends IUseCase<void, bool> {
  final LocalDatasource _localDatasource;
  LogoutUseCase({required LocalDatasource localDatasource})
      : _localDatasource = localDatasource;

  @override
  Future<Result<bool>> execute(void dto) async {
    try {
      await _localDatasource.removeKey('token');
      return Result.success<bool>(true);
    } catch (e) {
      return Result.failure<bool>(const UnknownException());
    }
  }
}
