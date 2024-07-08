import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/blocs/resettable_bloc.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blogs.use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';

part 'all_blogs_event.dart';
part 'all_blogs_state.dart';

class AllBlogsBloc extends Bloc<AllBlogsEvent, AllBlogsState>
    implements ResettableBloc {
  final GetBlogsUseCase getBlogsUseCase;
  final List<Blog> _cachedBlogs = [];

  AllBlogsBloc(this.getBlogsUseCase) : super(AllBlogsLoading()) {
    on<AllBlogsRequested>(_getAllBlogs);
  }

  Future<void> _getAllBlogs(
      AllBlogsRequested event, Emitter<AllBlogsState> emit) async {
    if (_cachedBlogs.isNotEmpty) {
      emit(AllBlogsSuccess(blogs: _cachedBlogs));
    } else {
      emit(AllBlogsLoading());
      final result =
          await getBlogsUseCase.execute(GetBlogsDto(page: event.page));
      if (result.isSuccessful) {
        _cachedBlogs.addAll(result.unwrap());
        emit(AllBlogsSuccess(blogs: _cachedBlogs));
      } else {
        try {
          throw result.unwrap();
        } catch (e) {
          emit(AllBlogsFailed(message: e.toString()));
        }
      }
    }
  }

  @override
  void reset() {
    _cachedBlogs.clear();
  }
}
