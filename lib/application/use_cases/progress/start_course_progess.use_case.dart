import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/progress/progress_repository.dart';

class StartCourseByIdDto {
  final String courseId;

  StartCourseByIdDto(this.courseId);
}

class StartCourseProgressUseCase extends IUseCase<StartCourseByIdDto, String> {
  final IProgressRepository progressRepository;

  StartCourseProgressUseCase(this.progressRepository);

  @override
  Future<Result<String>> execute(StartCourseByIdDto dto) async {
    return await progressRepository.startCourseProgress(dto.courseId);
  }
}
