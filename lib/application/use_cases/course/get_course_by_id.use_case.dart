import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

class GetCourseByIdDto {
  final String courseId;

  GetCourseByIdDto(this.courseId);
}

class GetCourseByIdUseCase extends IUseCase<GetCourseByIdDto, Course> {
  final ICourseRepository courseRepository;

  GetCourseByIdUseCase(this.courseRepository);

  @override
  Future<Result<Course>> execute(GetCourseByIdDto dto) async {
    return await courseRepository.getCourseById(dto.courseId);
  }
}
