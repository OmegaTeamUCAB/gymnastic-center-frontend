import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/resettable_bloc.dart';
import 'package:gymnastic_center/application/use_cases/course/get_courses.use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

part 'feature_courses_event.dart';
part 'feature_courses_state.dart';

class FeatureCoursesBloc extends Bloc<FeatureCoursesEvent, FeatureCoursesState>
    implements ResettableBloc {
  final GetCoursesUseCase getCoursesUseCase;
  final List<Course> _cachedCourses = [];

  FeatureCoursesBloc(this.getCoursesUseCase) : super(FeatureCoursesLoading()) {
    on<FeatureCoursesRequested>(_getFeatureCourses);
  }

  Future<void> _getFeatureCourses(
      FeatureCoursesRequested event, Emitter<FeatureCoursesState> emit) async {
    if (_cachedCourses.isNotEmpty) {
      emit(FeatureCoursesSuccess(courses: _cachedCourses));
    } else {
      emit(FeatureCoursesLoading());
      final result = await getCoursesUseCase
          .execute(GetCoursesDto(page: event.page, filter: 'POPULAR'));
      if (result.isSuccessful) {
        _cachedCourses.addAll(result.unwrap());
        emit(FeatureCoursesSuccess(courses: _cachedCourses));
      } else {
        try {
          throw result.unwrap();
        } catch (e) {
          emit(FeatureCoursesFailed(message: e.toString()));
        }
      }
    }
  }

  @override
  void reset() {
    _cachedCourses.clear();
  }
}
