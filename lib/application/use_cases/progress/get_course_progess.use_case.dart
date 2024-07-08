import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/progress/progress.dart';
import 'package:gymnastic_center/domain/progress/progress_repository.dart';

class GetCourseProgressByIdDto {
  final String courseId;

  GetCourseProgressByIdDto(this.courseId);
}

class GetCourseProgressByIdUseCase
    extends IUseCase<GetCourseProgressByIdDto, Progress> {
  final IProgressRepository progressRepository;

  GetCourseProgressByIdUseCase(this.progressRepository);

  @override
  Future<Result<Progress>> execute(GetCourseProgressByIdDto dto) async {
    return await progressRepository.getCourseProgressById(dto.courseId);
  }
}
