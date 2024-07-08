import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/blocs/resettable_bloc.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blog_by_id.use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
part 'blog_detail_event.dart';
part 'blog_detail_state.dart';

class BlogDetailBloc extends Bloc<BlogDetailEvent, BlogDetailState>
    implements ResettableBloc {
  final GetBlogByIdUseCase getBlogUseCase;
  final Map<String, Blog> _cachedBlogs = {};

  BlogDetailBloc(this.getBlogUseCase) : super(BlogDetailLoading()) {
    on<BlogDetailRequested>(_getBlogDetail);
  }

  Future<void> _getBlogDetail(
      BlogDetailRequested event, Emitter<BlogDetailState> emit) async {
    if (_cachedBlogs.containsKey(event.blogId)) {
      emit(BlogDetailLoaded(blog: _cachedBlogs[event.blogId]!));
    } else {
      emit(BlogDetailLoading());
      final result = await getBlogUseCase.execute(GetBlogByIdDto(event.blogId));
      if (result.isSuccessful) {
        _cachedBlogs[event.blogId] = result.unwrap();
        emit(BlogDetailLoaded(blog: _cachedBlogs[event.blogId]!));
      } else {
        try {
          throw result.unwrap();
        } catch (e) {
          emit(BlogDetailFailed(message: e.toString()));
        }
      }
    }
  }

  @override
  void reset() {
    _cachedBlogs.clear();
  }
}
