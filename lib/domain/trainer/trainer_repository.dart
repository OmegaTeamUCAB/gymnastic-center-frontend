import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';

class GetTrainersDto {
  final int page;
  final int? perPage;
  final String? filter;
  GetTrainersDto({this.perPage, required this.page, this.filter});
}

abstract class ITrainerRepository {
  Future<Result<Trainer>> getTrainerById(String id);
  Future<Result<List<Trainer>>> getTrainers(GetTrainersDto dto);
}
