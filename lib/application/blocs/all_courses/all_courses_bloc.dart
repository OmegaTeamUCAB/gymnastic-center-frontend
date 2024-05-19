import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/course/get_all_courses.use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';

part 'all_courses_event.dart';
part 'all_courses_state.dart';

class AllCoursesBloc extends Bloc<AllCoursesEvent, AllCoursesState> {
  final GetAllCoursesUseCase getAllCoursesUseCase;
  AllCoursesBloc(this.getAllCoursesUseCase) : super(AllCoursesLoading()) {
    on<AllCoursesRequested>(_getAllCourses);
  }

  Future<void> _getAllCourses(
      AllCoursesRequested event, Emitter<AllCoursesState> emit) async {
    emit(AllCoursesLoading());
    final result = await getAllCoursesUseCase.execute(GetAllCoursesDto());
    if (result.isSuccessful) {
      emit(AllCoursesSuccess(courses: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(AllCoursesFailed(message: e.toString()));
      }
    }
  }
}