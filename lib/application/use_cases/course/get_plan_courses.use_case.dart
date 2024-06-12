import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

class GetPlanCoursesUseCase extends IUseCase<GetCoursesDto, List<Course>> {
  final ICourseRepository courseRepository;

  GetPlanCoursesUseCase(this.courseRepository);

  @override
  Future<Result<List<Course>>> execute(GetCoursesDto dto) async {
    //TODO: implement getPlanCourses when backend is ready
    return await courseRepository.getCourses(GetCoursesDto(
      page: dto.page,
      // userId: dto.userId
    ));
  }
}
