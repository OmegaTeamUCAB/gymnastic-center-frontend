import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

class GetPlanCoursesDto {
  GetPlanCoursesDto();
}

class GetPlanCoursesUseCase extends IUseCase<GetPlanCoursesDto, List<Course>> {
  final ICourseRepository courseRepository;

  GetPlanCoursesUseCase(this.courseRepository);

  @override
  Future<Result<List<Course>>> execute(GetPlanCoursesDto dto) async {
    // return await courseRepository.getPlanCourses();
    //TODO: implement getPlanCourses when backend is ready
    return await courseRepository.getAllCourses(1);
  }
}
