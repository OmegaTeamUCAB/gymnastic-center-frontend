import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

class GetCoursesByCategoryDto {
  final String categoryId;
  final int page;

  GetCoursesByCategoryDto(this.categoryId, this.page);
}

class GetCoursesByCategoryUseCase
    extends IUseCase<GetCoursesByCategoryDto, List<Course>> {
  final ICourseRepository courseRepository;

  GetCoursesByCategoryUseCase(this.courseRepository);

  @override
  Future<Result<List<Course>>> execute(GetCoursesByCategoryDto dto) async {
    return await courseRepository.getCourses(GetCoursesDto(
      page: dto.page,
      categoryId: dto.categoryId,
    ));
  }
}
