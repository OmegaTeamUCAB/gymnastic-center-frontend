import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/comment/get_comments.use_case.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
import 'package:gymnastic_center/domain/comment/comment_repository.dart';

part 'blog_comments_event.dart';
part 'blog_comments_state.dart';

class BlogCommentsBloc extends Bloc<BlogCommentsEvent, BlogCommentsState> {
  final GetCommentsUseCase getCommentsUseCase;
  BlogCommentsBloc(this.getCommentsUseCase) : super(BlogCommentsLoading()) {
    on<BlogCommentsRequested>(_getBlogComments);
  }

  Future<void> _getBlogComments(
      BlogCommentsRequested event, Emitter<BlogCommentsState> emit) async {
    emit(BlogCommentsLoading());
    final result = await getCommentsUseCase
        .execute(GetCommentsDto(page: event.page, blogId: event.blogId));
    if (result.isSuccessful) {
      final previousComments = state is BlogCommentsSuccess
          ? (state as BlogCommentsSuccess).comments
          : <Comment>[];
      final currentComments = result.unwrap();
      final allComments = [...previousComments, ...currentComments];
      emit(BlogCommentsSuccess(comments: allComments));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(BlogCommentsFailed(message: e.toString()));
      }
    }
  }
}
