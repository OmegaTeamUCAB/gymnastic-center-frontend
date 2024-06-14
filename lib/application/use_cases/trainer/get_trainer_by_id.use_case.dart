import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';
import 'package:gymnastic_center/domain/trainer/trainer_repository.dart';

class GetTrainerByIdDto {
  final String trainerId;

  GetTrainerByIdDto(this.trainerId);
}

class GetTrainerByIdUseCase extends IUseCase<GetTrainerByIdDto, Trainer> {
  final ITrainerRepository trainerRepository;

  GetTrainerByIdUseCase(this.trainerRepository);

  @override
  Future<Result<Trainer>> execute(GetTrainerByIdDto dto) async {
    return await trainerRepository.getTrainerById(dto.trainerId);
  }
}
