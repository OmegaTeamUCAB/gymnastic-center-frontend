import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/viewed_courses/viewed_courses_state.dart';
import 'package:gymnastic_center/application/use_cases/progress/get_viewed_courses.use_case.dart';
import 'package:gymnastic_center/domain/progress/progress_repository.dart';

part 'viewed_courses_event.dart';

class ViewedCoursesBloc extends Bloc<ViewedCoursesEvent, ViewedCoursesState> {
  final GetViewedCoursesUseCase getViewedCoursesUseCase;

  ViewedCoursesBloc(this.getViewedCoursesUseCase)
      : super(ViewedCoursesLoading()) {
    on<ViewedCoursesRequested>(_getViewedCourses);
  }

  Future<void> _getViewedCourses(
      ViewedCoursesRequested event, Emitter<ViewedCoursesState> emit) async {
    emit(ViewedCoursesLoading());
    final result = await getViewedCoursesUseCase
        .execute(WatchingProgressDTO(page: 1, perPage: 15));
    if (result.isSuccessful) {
      emit(ViewedCoursesSuccess(courses: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(ViewedCoursesFailed(message: e.toString()));
      }
    }
  }
}
