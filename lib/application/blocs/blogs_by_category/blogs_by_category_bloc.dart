import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/blocs/blogs_by_category/blogs_by_category_event.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blogs.use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';

part 'blogs_by_category_state.dart';

class BlogsByCategoryBloc
    extends Bloc<BlogsByCategoryEvent, BlogsByCategoryState> {
  final GetBlogsUseCase getBlogsUseCase;
  BlogsByCategoryBloc({required this.getBlogsUseCase})
      : super(BlogsByCategoryLoading()) {
    on<BlogsByCategoryRequested>(_getBlogsByCategory);
  }

  Future<void> _getBlogsByCategory(BlogsByCategoryRequested event,
      Emitter<BlogsByCategoryState> emit) async {
    emit(BlogsByCategoryLoading());
    final result = await getBlogsUseCase
        .execute(GetBlogsDto(page: event.page, categoryId: event.categoryId));
    if (result.isSuccessful) {
      final previousBlogs = state is BlogsByCategorySuccess
          ? (state as BlogsByCategorySuccess).blogs
          : <Blog>[];
      final currentBlogs = result.unwrap();
      final allBlogs = [...previousBlogs, ...currentBlogs];
      emit(BlogsByCategorySuccess(blogs: allBlogs));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(BlogsByCategoryFailed(message: e.toString()));
      }
    }
  }
}
