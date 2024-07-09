import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/progress/progress.dart';
import 'package:gymnastic_center/domain/progress/progress_repository.dart';

class GetViewedCoursesUseCase
    extends IUseCase<WatchingProgressDTO, List<CourseProgress>> {
  final IProgressRepository progressRepository;

  GetViewedCoursesUseCase(this.progressRepository);

  @override
  Future<Result<List<CourseProgress>>> execute(WatchingProgressDTO dto) async {
    return await progressRepository.getWatchingCourses(dto);
  }
}
