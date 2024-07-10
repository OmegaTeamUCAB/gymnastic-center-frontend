import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blogs.use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';

part 'popular_blogs_event.dart';
part 'popular_blogs_state.dart';

class PopularBlogsBloc extends Bloc<PopularBlogsEvent, PopularBlogsState> {
  final GetBlogsUseCase getBlogsUseCase;

  PopularBlogsBloc(this.getBlogsUseCase) : super(PopularBlogsLoading()) {
    on<PopularBlogsRequested>(_getAllBlogs);
  }

  Future<void> _getAllBlogs(
      PopularBlogsRequested event, Emitter<PopularBlogsState> emit) async {
    emit(PopularBlogsLoading());
    final result = await getBlogsUseCase
        .execute(GetBlogsDto(page: event.page, sorting: event.filter));
    if (result.isSuccessful) {
      emit(PopularBlogsSuccess(blogs: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(PopularBlogsFailed(message: e.toString()));
      }
    }
  }
}
