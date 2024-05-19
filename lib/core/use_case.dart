import 'package:gymnastic_center/core/result.dart';

abstract class IUseCase<T, R> {
  Future<Result<R>> execute(T dto);
}
