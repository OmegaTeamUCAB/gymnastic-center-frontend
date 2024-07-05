import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/comment/get_comments.use_case.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
import 'package:gymnastic_center/domain/comment/comment_repository.dart';

part 'get_comments_event.dart';
part 'get_comments_state.dart';

class GetCommentsBloc extends Bloc<GetCommentsEvent, GetCommentsState> {
  final GetCommentsUseCase getCommentsUseCase;
  GetCommentsBloc(this.getCommentsUseCase) : super(GetCommentsLoading()) {
    on<CommentsRequested>(_getComments);
  }

  Future<void> _getComments(
      CommentsRequested event, Emitter<GetCommentsState> emit) async {
    emit(GetCommentsLoading());
    final result = await getCommentsUseCase
        .execute(GetCommentsDto(page: event.page, blogId: event.blogId));
    if (result.isSuccessful) {
      final previousComments = state is GetCommentsSuccess
          ? (state as GetCommentsSuccess).comments
          : <Comment>[];
      final currentComments = result.unwrap();
      final allComments = [...previousComments, ...currentComments];
      emit(GetCommentsSuccess(comments: allComments));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(GetCommentsFailed(message: e.toString()));
      }
    }
  }
}
