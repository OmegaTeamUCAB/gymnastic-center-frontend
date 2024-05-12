import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blog_by_id.use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
part 'blog_detail_event.dart';
part 'blog_detail_state.dart';

class BlogDetailBloc extends Bloc<BlogDetailEvent, BlogDetailState> {
  final GetBlogByIdUseCase getBlogUseCase;

  BlogDetailBloc({required this.getBlogUseCase}) : super(BlogDetailLoading()) {
    on<BlogDetailRequested>(_getBlogDetail);
  }

  Future<void> _getBlogDetail(
      BlogDetailRequested event, Emitter<BlogDetailState> emit) async {
    emit(BlogDetailLoading());
    final result = await getBlogUseCase.execute(GetBlogByIdDto(event.blogId));
    if(result.isSuccessful) {
      emit(BlogDetailLoaded(blog: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(BlogDetailFailed(message: e.toString()));
      }
    }
  }
}
