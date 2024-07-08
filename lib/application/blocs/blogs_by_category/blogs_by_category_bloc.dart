import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/blocs/blogs_by_category/blogs_by_category_event.dart';
import 'package:gymnastic_center/application/blocs/resettable_bloc.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blogs.use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';

part 'blogs_by_category_state.dart';

class BlogsByCategoryBloc
    extends Bloc<BlogsByCategoryEvent, BlogsByCategoryState>
    implements ResettableBloc {
  final GetBlogsUseCase getBlogsUseCase;
  final Map<String, List<Blog>> _cachedBlogsByCategory = {};

  BlogsByCategoryBloc({required this.getBlogsUseCase})
      : super(BlogsByCategoryLoading()) {
    on<BlogsByCategoryRequested>(_getBlogsByCategory);
  }

  Future<void> _getBlogsByCategory(BlogsByCategoryRequested event,
      Emitter<BlogsByCategoryState> emit) async {
    if (_cachedBlogsByCategory.containsKey(event.categoryId)) {
      emit(BlogsByCategorySuccess(
          blogs: _cachedBlogsByCategory[event.categoryId]!));
    } else {
      emit(BlogsByCategoryLoading());
      final result = await getBlogsUseCase
          .execute(GetBlogsDto(categoryId: event.categoryId, page: event.page));
      if (result.isSuccessful) {
        _cachedBlogsByCategory[event.categoryId] = result.unwrap();
        emit(BlogsByCategorySuccess(
            blogs: _cachedBlogsByCategory[event.categoryId]!));
      } else {
        try {
          throw result.unwrap();
        } catch (e) {
          emit(BlogsByCategoryFailed(message: e.toString()));
        }
      }
    }
  }

  @override
  void reset() {
    _cachedBlogsByCategory.clear();
  }
}
