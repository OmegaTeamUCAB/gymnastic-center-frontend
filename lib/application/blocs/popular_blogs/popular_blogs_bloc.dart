import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_popular_blogs.use_case.dart';

part 'popular_blogs_event.dart';
part 'popular_blogs_state.dart';

class PopularBlogsBloc extends Bloc<PopularBlogsEvent, PopularBlogsState> {
  final GetPopularBlogsUseCase getPopularBlogsUseCase;
  final List<Blog> _cachedBlogs = [];

  PopularBlogsBloc(this.getPopularBlogsUseCase) : super(PopularBlogsLoading()) {
    on<PopularBlogsRequested>(_getAllBlogs);
  }

  Future<void> _getAllBlogs(
      PopularBlogsRequested event, Emitter<PopularBlogsState> emit) async {
    if (_cachedBlogs.isNotEmpty) {
      emit(PopularBlogsSuccess(blogs: _cachedBlogs));
    } else {
      emit(PopularBlogsLoading());
      final result =
          await getPopularBlogsUseCase.execute(GetBlogsDto(page: event.page));
      if (result.isSuccessful) {
        _cachedBlogs.addAll(result.unwrap());
        emit(PopularBlogsSuccess(blogs: _cachedBlogs));
      } else {
        try {
          throw result.unwrap();
        } catch (e) {
          emit(PopularBlogsFailed(message: e.toString()));
        }
      }
    }
  }
}
