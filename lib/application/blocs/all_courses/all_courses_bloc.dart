import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/course/get_all_courses.use_case.dart';
import 'package:gymnastic_center/domain/course/course.dart';

part 'all_courses_event.dart';
part 'all_courses_state.dart';

class AllCoursesBloc extends Bloc<AllCoursesEvent, AllCoursesState> {
  final GetAllCoursesUseCase getAllCoursesUseCase;
  int page = 1;
  int perPage = 15;
  bool lastPage = false;
  bool loadingPage = false;

  AllCoursesBloc(this.getAllCoursesUseCase) : super(AllCoursesLoading(courses: [])) {
    on<AllCoursesRequested>(_getAllCourses);
    on<NextPageLoaded>(_loadPage);
  }

  Future<void> _loadPage(NextPageLoaded event, Emitter<AllCoursesState> emit) async {
    loadingPage = true;
    final result = await getAllCoursesUseCase.execute(GetAllCoursesDto(page: page, perPage: perPage));
    if (result.isSuccessful) {
      page = page + 1;
      loadingPage = false;
      final courses = result.unwrap();
      if(courses.isEmpty) lastPage = true;
      emit(AllCoursesSuccess(courses: [...state.courses, ...courses]));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(AllCoursesFailed(message: e.toString(), courses: state.courses));
      }
    }
  }

  Future<void> loadNextPage() async {
    if(state is AllCoursesFailed || lastPage == true || loadingPage == true) return;
    
    add(NextPageLoaded());
  }

  Future<void> _getAllCourses(
      AllCoursesRequested event, Emitter<AllCoursesState> emit) async {
    emit(AllCoursesLoading(courses: state.courses));
    final result = await getAllCoursesUseCase.execute(GetAllCoursesDto(page: page, perPage: perPage));
    if (result.isSuccessful) {
      page = page + 1;
      emit(AllCoursesSuccess(courses: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(AllCoursesFailed(message: e.toString(), courses: state.courses));
      }
    }
  }
}
