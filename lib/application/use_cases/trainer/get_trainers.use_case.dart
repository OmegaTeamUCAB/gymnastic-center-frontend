import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';
import 'package:gymnastic_center/domain/trainer/trainer_repository.dart';

class GetTrainersUseCase extends IUseCase<GetTrainersDto, List<Trainer>> {
  final ITrainerRepository trainerRepository;

  GetTrainersUseCase(this.trainerRepository);

  @override
  Future<Result<List<Trainer>>> execute(GetTrainersDto dto) async {
    return await trainerRepository.getTrainers(dto);
  }
}
