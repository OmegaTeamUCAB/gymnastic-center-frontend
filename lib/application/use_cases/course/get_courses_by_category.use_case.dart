import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

class GetCoursesByCategoryDto {
  final String category;

  GetCoursesByCategoryDto(this.category);
}

class GetCoursesByCategoryUseCase
    extends IUseCase<GetCoursesByCategoryDto, List<Course>> {
  final ICourseRepository courseRepository;

  GetCoursesByCategoryUseCase(this.courseRepository);

  @override
  Future<Result<List<Course>>> execute(GetCoursesByCategoryDto dto) async {
    return await courseRepository.getCoursesByCategoryNew(dto.category);
  }
}
