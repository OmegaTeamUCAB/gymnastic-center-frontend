import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/course_repository.dart';

class GetAllCoursesByTrainerDto {
  final int page;
  final String trainerId;

  GetAllCoursesByTrainerDto(this.page, this.trainerId);
}

class GetAllCoursesByTrainerUseCase
    extends IUseCase<GetAllCoursesByTrainerDto, List<Course>> {
  final CourseRepository courseRepository;

  GetAllCoursesByTrainerUseCase(this.courseRepository);

  @override
  Future<Result<List<Course>>> execute(GetAllCoursesByTrainerDto dto) async {
    return courseRepository.getCoursesByTrainer(dto.page, dto.trainerId);
  }
}
