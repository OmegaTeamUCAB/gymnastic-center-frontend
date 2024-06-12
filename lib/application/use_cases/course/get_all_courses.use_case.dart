import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

class GetAllCoursesUseCase extends IUseCase<GetCoursesDto, List<Course>> {
  final ICourseRepository courseRepository;

  GetAllCoursesUseCase(this.courseRepository);

  @override
  Future<Result<List<Course>>> execute(GetCoursesDto dto) async {
    return await courseRepository.getCourses(GetCoursesDto(
      page: dto.page,
    ));
  }
}
