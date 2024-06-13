import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blogs.use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';

part 'all_blogs_event.dart';
part 'all_blogs_state.dart';

class AllBlogsBloc extends Bloc<AllBlogsEvent, AllBlogsState> {
  final GetBlogsUseCase getBlogsUseCase;
  AllBlogsBloc(this.getBlogsUseCase) : super(AllBlogsLoading()) {
    on<AllBlogsRequested>(_getAllBlogs);
  }

  Future<void> _getAllBlogs(
      AllBlogsRequested event, Emitter<AllBlogsState> emit) async {
    emit(AllBlogsLoading());
    final result = await getBlogsUseCase.execute(GetBlogsDto(page: event.page));
    if (result.isSuccessful) {
      final previousBlogs = state is AllBlogsSuccess
          ? (state as AllBlogsSuccess).blogs
          : <Blog>[];
      final currentBlogs = result.unwrap();
      final allBlogs = [...previousBlogs, ...currentBlogs];
      emit(AllBlogsSuccess(blogs: allBlogs));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(AllBlogsFailed(message: e.toString()));
      }
    }
  }
}
