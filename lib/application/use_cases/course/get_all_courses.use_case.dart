import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

class GetAllCoursesDto {
  final int page;
  final int perPage;

  GetAllCoursesDto({required this.page, required this.perPage});
}

class GetAllCoursesUseCase extends IUseCase<GetAllCoursesDto, List<Course>> {
  final ICourseRepository courseRepository;

  GetAllCoursesUseCase(this.courseRepository);

  @override
  Future<Result<List<Course>>> execute(GetAllCoursesDto dto) async {
    return await courseRepository.getAllCourses(page: dto.page, perPage: dto.perPage);
  }
}
