import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/progress/progress_repository.dart';

class GetViewedCoursesUseCase
    extends IUseCase<WatchingProgressDTO, List<Course>> {
  final IProgressRepository progressRepository;

  GetViewedCoursesUseCase(this.progressRepository);

  @override
  Future<Result<List<Course>>> execute(WatchingProgressDTO dto) async {
    return await progressRepository.getWatchingCourses(dto);
  }
}
