import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/blocs/resettable_bloc.dart';
import 'package:gymnastic_center/application/use_cases/course/get_courses.use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';
import 'package:gymnastic_center/domain/course/course_repository.dart';

part 'all_courses_event.dart';
part 'all_courses_state.dart';

class AllCoursesBloc extends Bloc<AllCoursesEvent, AllCoursesState>
    implements ResettableBloc {
  final GetCoursesUseCase getCoursesUseCase;
  final List<Course> _cachedCourses = [];

  AllCoursesBloc(this.getCoursesUseCase) : super(AllCoursesLoading()) {
    on<AllCoursesRequested>(_getAllCourses);
  }

  Future<void> _getAllCourses(
      AllCoursesRequested event, Emitter<AllCoursesState> emit) async {
    if (_cachedCourses.isNotEmpty) {
      emit(AllCoursesSuccess(courses: _cachedCourses));
    } else {
      emit(AllCoursesLoading());
      final result =
          await getCoursesUseCase.execute(GetCoursesDto(page: event.page));
      if (result.isSuccessful) {
        _cachedCourses.addAll(result.unwrap());
        emit(AllCoursesSuccess(courses: _cachedCourses));
      } else {
        try {
          throw result.unwrap();
        } catch (e) {
          emit(AllCoursesFailed(message: e.toString()));
        }
      }
    }
  }

  @override
  void reset() {
    _cachedCourses.clear();
  }
}
