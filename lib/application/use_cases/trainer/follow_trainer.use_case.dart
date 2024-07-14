import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/trainer/trainer_repository.dart';

class FollowTrainerDto {
  final String trainerId;

  FollowTrainerDto(this.trainerId);
}

class FollowTrainersUseCase extends IUseCase<FollowTrainerDto, void> {
  final ITrainerRepository trainerRepository;

  FollowTrainersUseCase(this.trainerRepository);

  @override
  Future<Result<void>> execute(FollowTrainerDto dto) async {
    return await trainerRepository.followTrainer(dto.trainerId);
  }
}