import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';

abstract class ITrainerRepository {
  Future<Result<Trainer>> getTrainerById(String id);
  Future<Result<List<Trainer>>> getTrainers();
}
