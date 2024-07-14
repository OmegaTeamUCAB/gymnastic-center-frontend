import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/use_cases/course/get_courses.use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

part 'feature_courses_event.dart';
part 'feature_courses_state.dart';

class FeatureCoursesBloc
    extends Bloc<FeatureCoursesEvent, FeatureCoursesState> {
  final GetCoursesUseCase getCoursesUseCase;

  FeatureCoursesBloc(this.getCoursesUseCase) : super(FeatureCoursesLoading()) {
    on<FeatureCoursesRequested>(_getFeatureCourses);
  }

  Future<void> _getFeatureCourses(
      FeatureCoursesRequested event, Emitter<FeatureCoursesState> emit) async {
    emit(FeatureCoursesLoading());
    final result = await getCoursesUseCase
        .execute(GetCoursesDto(page: event.page, filter: 'POPULAR'));
    if (result.isSuccessful) {
      emit(FeatureCoursesSuccess(courses: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(FeatureCoursesFailed(message: e.toString()));
      }
    }
  }
}
