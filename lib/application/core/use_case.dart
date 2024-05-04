import 'package:gymnastic_center/application/core/result.dart';

abstract class IUseCase<T extends Object, R> {
  Future<Result<R>> execute(T params);
}
