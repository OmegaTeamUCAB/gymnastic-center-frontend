import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/progress/progress_repository.dart';

class UpdateCourseProgressUseCase extends IUseCase<UpdateProgressDTO, String> {
  final IProgressRepository progressRepository;

  UpdateCourseProgressUseCase(this.progressRepository);

  @override
  Future<Result<String>> execute(UpdateProgressDTO dto) async {
    return await progressRepository.updateCourseProgress(dto);
  }
}
