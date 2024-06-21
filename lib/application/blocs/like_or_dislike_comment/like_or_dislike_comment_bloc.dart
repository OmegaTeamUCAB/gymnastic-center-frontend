import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/use_cases/comment/like_or_dislike_comment.use_case.dart';

part 'like_or_dislike_comment_event.dart';
part 'like_or_dislike_comment_state.dart';

class LikeOrDislikeCommentBloc
    extends Bloc<LikeOrDislikeCommentEvent, LikeOrDislikeCommentState> {
  final LikeOrDislikeCommentUseCase? likeOrDislikeCommentUseCase;

  LikeOrDislikeCommentBloc({this.likeOrDislikeCommentUseCase})
      : super(LikeOrDislikeCommentLoading()) {
    on<LikeOrDislikeCommentRequested>(likeOrDislikeComment);
  }

  Future<void> likeOrDislikeComment(LikeOrDislikeCommentRequested event,
      Emitter<LikeOrDislikeCommentState> emit) async {
    emit(LikeOrDislikeCommentLoading());
    final result = await likeOrDislikeCommentUseCase!.execute(
      LikeOrDislikeCommentByIdDto(
        commentId: event.commentId,
        like: event.like,
      ),
    );
    if (result.isSuccessful) {
      emit(LikeOrDislikeCommentSuccess());
    } else {
      emit(LikeOrDislikeCommentFailed(message: result.error.message));
    }
  }
}
