import 'package:gymnastic_center/core/result.dart';

abstract class IUseCase<T extends Object, R> {
  Future<Result<R>> execute(T dto);
}
